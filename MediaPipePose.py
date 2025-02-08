import cv2
import mediapipe as mp
import numpy as np
import math

mp_pose = mp.solutions.pose
mp_draw = mp.solutions.drawing_utils

pose = mp_pose.Pose()
cap = cv2.VideoCapture("C:\\Users\\DELL\\Desktop\\TrainEZ\\TrainEZ\\Squat side View.mp4")

pose_landmarks_data = []

def calculate_angle(a, b, c):
    a = np.array(a)
    b = np.array(b)
    c = np.array(c)

    ab = b - a
    bc = c - b
    
    # Calculating angles
    cos_angle = np.dot(ab, bc) / (np.linalg.norm(ab) * np.linalg.norm(bc))
    angle = np.arccos(np.clip(cos_angle, -1.0, 1.0))
    angle = np.degrees(angle)  # Corrected here
    return angle

while True:
    ret, img = cap.read()
    if not ret:
        break
    
    img = cv2.resize(img, (600, 400))

    results = pose.process(img)
    
    # Draw pose landmarks
    if results.pose_landmarks:
        mp_draw.draw_landmarks(img, results.pose_landmarks, mp_pose.POSE_CONNECTIONS)
        landmarks = []
        for landmark in results.pose_landmarks.landmark:
            landmarks.append([landmark.x, landmark.y, landmark.z])
        pose_landmarks_data.append(landmarks)

    # Getting left hip, knee, and ankle
    left_hip = [results.pose_landmarks.landmark[mp_pose.PoseLandmark.LEFT_HIP].x,
                results.pose_landmarks.landmark[mp_pose.PoseLandmark.LEFT_HIP].y]
    left_knee = [results.pose_landmarks.landmark[mp_pose.PoseLandmark.LEFT_KNEE].x,
                 results.pose_landmarks.landmark[mp_pose.PoseLandmark.LEFT_KNEE].y]
    left_ankle = [results.pose_landmarks.landmark[mp_pose.PoseLandmark.LEFT_ANKLE].x,
                  results.pose_landmarks.landmark[mp_pose.PoseLandmark.LEFT_ANKLE].y]

    # Getting right hip, knee, and ankle
    right_hip = [results.pose_landmarks.landmark[mp_pose.PoseLandmark.RIGHT_HIP].x,
                 results.pose_landmarks.landmark[mp_pose.PoseLandmark.RIGHT_HIP].y]
    right_knee = [results.pose_landmarks.landmark[mp_pose.PoseLandmark.RIGHT_KNEE].x,
                  results.pose_landmarks.landmark[mp_pose.PoseLandmark.RIGHT_KNEE].y]
    right_ankle = [results.pose_landmarks.landmark[mp_pose.PoseLandmark.RIGHT_ANKLE].x,
                   results.pose_landmarks.landmark[mp_pose.PoseLandmark.RIGHT_ANKLE].y]

    # Calculate the angles of the left and right knees
    left_knee_angle = calculate_angle(left_hip, left_knee, left_ankle)
    right_knee_angle = calculate_angle(right_hip, right_knee, right_ankle)

    # Display angles on the image
    cv2.putText(img, f'Left Knee Angle: {int(left_knee_angle)}', (10, 30),
                cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2, cv2.LINE_AA)
    cv2.putText(img, f'Right Knee Angle: {int(right_knee_angle)}', (10, 70),
                cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2, cv2.LINE_AA)
    
    # Squat detection logic
    squat_threshold = 90
    if left_knee_angle < squat_threshold and right_knee_angle < squat_threshold:
        cv2.putText(img, 'Not Enough Depth', (10, 110), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2, cv2.LINE_AA)

    # Bend detection (adjusted thresholds)
    if abs(left_hip[1] - left_knee[1]) > 0.1:  # Adjust threshold as needed
        if left_hip[1] > left_knee[1]:
            cv2.putText(img, 'Bend Backwards Detected!', (10, 150), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2, cv2.LINE_AA)
        else:
            cv2.putText(img, 'Bend Forwards Detected!', (10, 150), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2, cv2.LINE_AA)
    
    # Display original pose estimation
    cv2.imshow("Pose Estimation", img)
    
    # Check if the window is closed or 'q' is pressed
    if cv2.waitKey(1) & 0xFF == ord('q') or cv2.getWindowProperty("Pose Estimation", cv2.WND_PROP_VISIBLE) < 1:
        break

cap.release()
cv2.destroyAllWindows()

pose_landmarks_array = np.array(pose_landmarks_data)
print(pose_landmarks_array)
