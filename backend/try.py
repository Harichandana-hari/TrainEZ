from flask import Flask, request
from flask_socketio import SocketIO, emit
import cv2
import mediapipe as mp
import numpy as np
import base64

app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins="*")  # Allow Flutter to connect

# Initialize MediaPipe Pose
mp_pose = mp.solutions.pose
pose = mp_pose.Pose()

# Function to calculate joint angles
def calculate_angle(a, b, c):
    a, b, c = np.array(a), np.array(b), np.array(c)
    ab, bc = b - a, c - b
    cos_angle = np.dot(ab, bc) / (np.linalg.norm(ab) * np.linalg.norm(bc))
    return np.degrees(np.arccos(np.clip(cos_angle, -1.0, 1.0)))

# WebSocket event to receive frames from Flutter
@socketio.on('frame')
def handle_frame(data):
    try:
        # Decode base64 image
        image_bytes = base64.b64decode(data['image'])
        np_arr = np.frombuffer(image_bytes, np.uint8)
        frame = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)

        # Convert BGR to RGB
        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

        # Process the image with MediaPipe Pose
        results = pose.process(frame_rgb)

        feedback = "No Pose Detected"

        if results.pose_landmarks:
            landmarks = results.pose_landmarks.landmark

            # Extract relevant landmarks
            left_hip = [landmarks[mp_pose.PoseLandmark.LEFT_HIP.value].x, landmarks[mp_pose.PoseLandmark.LEFT_HIP.value].y]
            left_knee = [landmarks[mp_pose.PoseLandmark.LEFT_KNEE.value].x, landmarks[mp_pose.PoseLandmark.LEFT_KNEE.value].y]
            left_ankle = [landmarks[mp_pose.PoseLandmark.LEFT_ANKLE.value].x, landmarks[mp_pose.PoseLandmark.LEFT_ANKLE.value].y]

            right_hip = [landmarks[mp_pose.PoseLandmark.RIGHT_HIP.value].x, landmarks[mp_pose.PoseLandmark.RIGHT_HIP.value].y]
            right_knee = [landmarks[mp_pose.PoseLandmark.RIGHT_KNEE.value].x, landmarks[mp_pose.PoseLandmark.RIGHT_KNEE.value].y]
            right_ankle = [landmarks[mp_pose.PoseLandmark.RIGHT_ANKLE.value].x, landmarks[mp_pose.PoseLandmark.RIGHT_ANKLE.value].y]

            # Calculate angles
            left_knee_angle = calculate_angle(left_hip, left_knee, left_ankle)
            right_knee_angle = calculate_angle(right_hip, right_knee, right_ankle)

            # Analyze squat depth
            squat_threshold, standing_threshold = 90, 160

            if left_knee_angle < squat_threshold and right_knee_angle < squat_threshold:
                feedback = "Deep Squat Detected!"
            elif squat_threshold <= left_knee_angle < standing_threshold and squat_threshold <= right_knee_angle < standing_threshold:
                feedback = "Partial Squat Detected!"
            elif left_knee_angle >= standing_threshold and right_knee_angle >= standing_threshold:
                feedback = "Standing Detected!"

        # Send feedback back to Flutter via WebSocket
        emit('feedback', {'message': feedback})

    except Exception as e:
        emit('error', {'message': str(e)})

if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=5000, debug=True)
