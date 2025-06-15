<%--
  Created by IntelliJ IDEA.
  User: Nethushi
  Date: 6/11/2025
  Time: 2:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">
  <title>Employee Registration</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #000000 0%, #171717 50%, #000000 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      color: #e0e0e0;
    }

    .container {
      background: rgba(30, 30, 30, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
      border: 1px solid rgba(255, 140, 0, 0.2);
      padding: 40px;
      width: 100%;
      max-width: 500px;
      animation: slideUp 0.6s ease-out;
    }

    @keyframes slideUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .header {
      text-align: center;
      margin-bottom: 30px;
    }

    .header h2 {
      color: #ff8c00;
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 8px;
      text-shadow: 0 0 10px rgba(255, 140, 0, 0.3);
    }

    .header p {
      color: #b0b0b0;
      font-size: 14px;
    }

    .form-group {
      margin-bottom: 20px;
      position: relative;
    }

    .form-group label {
      display: block;
      color: #e0e0e0;
      font-weight: 600;
      margin-bottom: 8px;
      font-size: 14px;
    }

    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 12px 16px;
      border: 2px solid #404040;
      border-radius: 10px;
      font-size: 16px;
      transition: all 0.3s ease;
      background: #2a2a2a;
      color: #e0e0e0;
    }

    .form-group input:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: #ff8c00;
      box-shadow: 0 0 0 3px rgba(255, 140, 0, 0.2);
      transform: translateY(-2px);
      background: #333333;
    }

    .form-group input::placeholder,
    .form-group textarea::placeholder {
      color: #888;
    }

    .form-group textarea {
      resize: vertical;
      min-height: 80px;
    }

    .password-group {
      position: relative;
    }

    .password-toggle {
      position: absolute;
      right: 12px;
      top: 50%;
      transform: translateY(-50%);
      cursor: pointer;
      color: #ff8c00;
      font-size: 18px;
      user-select: none;
      transition: color 0.3s ease;
    }

    .password-toggle:hover {
      color: #ffa500;
    }

    .submit-btn {
      width: 100%;
      background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
      color: #000;
      padding: 14px;
      border: none;
      border-radius: 10px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      margin-top: 10px;
      box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
    }

    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(255, 140, 0, 0.5);
      background: linear-gradient(135deg, #ffa500 0%, #ff7700 100%);
    }

    .submit-btn:active {
      transform: translateY(0);
    }

    .login-link {
      text-align: center;
      margin-top: 25px;
      padding-top: 20px;
      border-top: 1px solid #404040;
    }

    .login-link p {
      color: #b0b0b0;
      font-size: 14px;
    }

    .login-link a {
      color: #ff8c00;
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
    }

    .login-link a:hover {
      color: #ffa500;
      text-shadow: 0 0 5px rgba(255, 140, 0, 0.5);
    }

    .form-row {
      display: flex;
      gap: 15px;
    }

    .form-row .form-group {
      flex: 1;
    }

    @media (max-width: 600px) {
      .container {
        padding: 25px;
        margin: 10px;
      }

      .form-row {
        flex-direction: column;
        gap: 0;
      }
    }

    .strength-meter {
      height: 4px;
      background: #404040;
      border-radius: 2px;
      margin-top: 5px;
      overflow: hidden;
    }

    .strength-fill {
      height: 100%;
      width: 0%;
      transition: all 0.3s ease;
      border-radius: 2px;
    }

    .strength-weak { background: #ff4757; width: 25%; }
    .strength-fair { background: #ffa502; width: 50%; }
    .strength-good { background: #ff8c00; width: 75%; }
    .strength-strong { background: #32cd32; width: 100%; }

    /* Profile Picture Upload Styles - Fixed */
    .image-upload-container {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 15px;
      width: 100%;
    }

    .image-preview {
      width: 120px;
      height: 120px;
      border: 3px dashed #404040;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
      background: #2a2a2a;
      flex-shrink: 0;
    }

    .image-preview:hover {
      border-color: #ff8c00;
      background: #333333;
      transform: scale(1.05);
      box-shadow: 0 0 20px rgba(255, 140, 0, 0.3);
    }

    .image-preview.has-image {
      border-style: solid;
      border-color: #ff8c00;
    }

    .placeholder-icon {
      text-align: center;
      color: #888;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      width: 100%;
      height: 100%;
    }

    .placeholder-icon svg {
      margin-bottom: 8px;
      stroke: #ff8c00;
      flex-shrink: 0;
    }

    .placeholder-icon p {
      font-size: 11px;
      margin: 0;
      font-weight: 500;
      color: #b0b0b0;
      line-height: 1.2;
      text-align: center;
    }

    #previewImg {
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius: 50%;
      position: absolute;
      top: 0;
      left: 0;
    }

    .image-overlay {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.7);
      display: flex;
      align-items: center;
      justify-content: center;
      opacity: 0;
      transition: opacity 0.3s ease;
      border-radius: 50%;
    }

    .image-preview:hover .image-overlay {
      opacity: 1;
    }

    .remove-btn {
      background: #ff4757;
      color: white;
      border: none;
      border-radius: 50%;
      width: 30px;
      height: 30px;
      font-size: 18px;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: bold;
      transition: all 0.2s ease;
    }

    .remove-btn:hover {
      background: #ff3742;
      transform: scale(1.1);
    }

    /* Hidden file input */
    #profile_image {
      display: none !important;
      visibility: hidden;
      position: absolute;
      top: -9999px;
    }

    /* Scrollbar styling for dark theme */
    ::-webkit-scrollbar {
      width: 8px;
    }

    ::-webkit-scrollbar-track {
      background: #2a2a2a;
    }

    ::-webkit-scrollbar-thumb {
      background: #ff8c00;
      border-radius: 4px;
    }

    ::-webkit-scrollbar-thumb:hover {
      background: #ffa500;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="header">
    <h2>Employee Registration</h2>
    <p>Create your account to get started</p>
  </div>

  <form action="register" method="post" id="signupForm" enctype="multipart/form-data">
    <!-- Profile Picture Upload Section - Fixed -->
    <div class="form-group">
      <label for="profile_image">Profile Picture</label>
      <div class="image-upload-container">
        <div class="image-preview" id="imagePreview">
          <div class="placeholder-icon" id="placeholderIcon">
            <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
              <circle cx="12" cy="7" r="4"></circle>
            </svg>
            <p>Click to upload<br>photo</p>
          </div>
          <img id="previewImg" src="" alt="Profile Preview" style="display: none;">
          <div class="image-overlay" id="imageOverlay" style="display: none;">
            <button type="button" class="remove-btn" onclick="removeImage()">×</button>
          </div>
        </div>
      </div>
      <input type="file" id="profile_image" name="profilePic" accept="image/*" required>
    </div>

    <div class="form-group">
      <label for="full_name">Full Name</label>
      <input type="text" id="full_name" name="fullName" required>
    </div>

    <div class="form-group">
      <label for="address">Address</label>
      <textarea id="address" name="address" placeholder="Enter your complete address" required></textarea>
    </div>

    <div class="form-row">
      <div class="form-group">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" required>
      </div>

      <div class="form-group">
        <label for="email">Email Address</label>
        <input type="email" id="email" name="email" required>
      </div>
    </div>

    <div class="form-group">
      <label for="password">Password</label>
      <div class="password-group">
        <input type="password" id="password" name="password" required>
        <span class="password-toggle" onclick="togglePassword('password')">
          <i class="fas fa-eye"></i>
        </span>
      </div>
      <div class="strength-meter">
        <div class="strength-fill" id="strengthFill"></div>
      </div>
    </div>

    <div class="form-group">
      <label for="confirm_password">Confirm Password</label>
      <div class="password-group">
        <input type="password" id="confirm_password" name="confirmPassword" required>
        <span class="password-toggle" onclick="togglePassword('confirm_password')">
          <i class="fas fa-eye"></i>
        </span>
      </div>
    </div>

    <input type="hidden" name="role" value="EMPLOYEE">

    <button type="submit" class="submit-btn">Create Account</button>
  </form>

  <div class="login-link">
    <p>Already have an account? <a href="index.jsp">Sign in here</a></p>
  </div>
</div>

<script src="js/signup.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>