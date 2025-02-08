from flask import Flask, request, jsonify
import cv2
import mediapipe as mp
import numpy as np
import base64
from io import BytesIO
from PIL import Image

app = Flask(__name__)

mp_pose = mp.solutions.pose
pose = mp_pose.Pose()

# Function to calculate joint angles
def calculate_angle(a, b, c):
    a = np.array(a)
    b = np.array(b)
    c = np.array(c)

    ab = b - a
    bc = c - b
    
    cos_angle = np.dot(ab, bc) / (np.linalg.norm(ab) * np.linalg.norm(bc))
    angle = np.arccos(np.clip(cos_angle, -1.0, 1.0))
    return np.degrees(angle)

@app.route('/', methods=['POST'])
def analyze_pose():
    data = request.json
    image_data = data.get('image')

    if not image_data:
        return jsonify({'error': 'No image data provided'}), 400

    # Decode the base64 image
    image_bytes = base64.b64decode(image_data)
    image = Image.open(BytesIO(image_bytes)).convert('RGB')
    image_np = np.array(image)

    # Convert RGB to BGR for OpenCV
    image_np = cv2.cvtColor(image_np, cv2.COLOR_RGB2BGR)

    # Process the image with MediaPipe Pose
    results = pose.process(image_np)

    if not results.pose_landmarks:
        return jsonify({'error': 'No pose detected'}), 400

    landmarks = results.pose_landmarks.landmark

    # Extract relevant landmarks
    left_hip = [landmarks[mp_pose.PoseLandmark.LEFT_HIP].x, landmarks[mp_pose.PoseLandmark.LEFT_HIP].y]
    left_knee = [landmarks[mp_pose.PoseLandmark.LEFT_KNEE].x, landmarks[mp_pose.PoseLandmark.LEFT_KNEE].y]
    left_ankle = [landmarks[mp_pose.PoseLandmark.LEFT_ANKLE].x, landmarks[mp_pose.PoseLandmark.LEFT_ANKLE].y]

    right_hip = [landmarks[mp_pose.PoseLandmark.RIGHT_HIP].x, landmarks[mp_pose.PoseLandmark.RIGHT_HIP].y]
    right_knee = [landmarks[mp_pose.PoseLandmark.RIGHT_KNEE].x, landmarks[mp_pose.PoseLandmark.RIGHT_KNEE].y]
    right_ankle = [landmarks[mp_pose.PoseLandmark.RIGHT_ANKLE].x, landmarks[mp_pose.PoseLandmark.RIGHT_ANKLE].y]

    # Calculate angles
    left_knee_angle = calculate_angle(left_hip, left_knee, left_ankle)
    right_knee_angle = calculate_angle(right_hip, right_knee, right_ankle)

    # Analyze pose
    squat_threshold = 90  # Minimum angle for good squat depth
    standing_threshold = 140  # Above this, consider as standing up

    feedback = []

    # Check if user is squatting
    if squat_threshold < left_knee_angle < standing_threshold and squat_threshold < right_knee_angle < standing_threshold:
        # User is squatting, check for bend issues
        if abs(left_hip[1] - left_knee[1]) > 0.1:
            if left_hip[1] > left_knee[1]:
                feedback.append('Bend Backwards Detected!')
            else:
                feedback.append('Bend Forwards Detected!')

    return jsonify({'feedback': feedback})

@app.route('/favicon.ico')
def favicon():
    return '', 204

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
