<%--
  Created by IntelliJ IDEA.
  User: Nethushi
  Date: 6/11/2025
  Time: 12:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">
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
            max-width: 450px;
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
            margin-bottom: 40px;
        }

        .header h2 {
            color: #ff8c00;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 8px;
            text-shadow: 0 0 15px rgba(255, 140, 0, 0.4);
        }

        .header p {
            color: #b0b0b0;
            font-size: 16px;
            margin-bottom: 10px;
        }

        .welcome-icon {
            font-size: 60px;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            color: #e0e0e0;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 15px;
        }

        .form-group input {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #404040;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #2a2a2a;
            color: #e0e0e0;
        }

        .form-group input:focus {
            outline: none;
            border-color: #ff8c00;
            box-shadow: 0 0 0 4px rgba(255, 140, 0, 0.2);
            transform: translateY(-2px);
            background: #333333;
        }

        .form-group input::placeholder {
            color: #888;
        }

        .password-group {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #ff8c00;
            font-size: 20px;
            user-select: none;
            transition: all 0.3s ease;
        }

        .password-toggle:hover {
            color: #ffa500;
            transform: translateY(-50%) scale(1.1);
        }

        .login-btn {
            width: 100%;
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            color: #000;
            padding: 16px;
            border: none;
            border-radius: 12px;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            box-shadow: 0 6px 20px rgba(255, 140, 0, 0.4);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(255, 140, 0, 0.6);
            background: linear-gradient(135deg, #ffa500 0%, #ff7700 100%);
        }

        .login-btn:active {
            transform: translateY(-1px);
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0 30px 0;
            font-size: 14px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #b0b0b0;
        }

        .remember-me input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #ff8c00;
            cursor: pointer;
        }

        .forgot-password {
            color: #ff8c00;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .forgot-password:hover {
            color: #ffa500;
            text-shadow: 0 0 8px rgba(255, 140, 0, 0.6);
        }

        .signup-link {
            text-align: center;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid #404040;
        }

        .signup-link p {
            color: #b0b0b0;
            font-size: 15px;
        }

        .signup-link a {
            color: #ff8c00;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .signup-link a:hover {
            color: #ffa500;
            text-shadow: 0 0 8px rgba(255, 140, 0, 0.6);
        }

        @media (max-width: 600px) {
            .container {
                padding: 30px 25px;
                margin: 10px;
            }

            .header h2 {
                font-size: 28px;
            }

            .welcome-icon {
                font-size: 50px;
            }

            .remember-forgot {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
        }

        /* Input field icons */
        .input-with-icon {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #ff8c00;
            font-size: 18px;
            pointer-events: none;
        }

        .input-with-icon input {
            padding-left: 50px;
        }

        /* Loading animation for button */
        .login-btn.loading {
            position: relative;
            color: transparent;
        }

        .login-btn.loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 20px;
            height: 20px;
            border: 2px solid #000;
            border-top: 2px solid transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
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
        <div class="welcome-icon">👋</div>
        <h2>Login</h2>
        <p>Welcome back! Please sign in to your account</p>
    </div>

    <form action="login" method="post" id="loginForm">
        <div class="form-group">
            <label for="username">Username</label>
            <div class="input-with-icon">
                <span class="input-icon"><i class="fas fa-user"></i></span>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
            </div>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <div class="input-with-icon password-group">
                <span class="input-icon"><i class="fas fa-lock"></i></span>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <span class="password-toggle" onclick="togglePassword('password')">
                    <i class="fas fa-eye"></i>
                </span>
            </div>
        </div>

        <div class="remember-forgot">
            <label class="remember-me">
                <input type="checkbox" id="remember" name="remember">
                Remember me
            </label>
            <a href="#" class="forgot-password">Forgot Password?</a>
        </div>

        <button type="submit" class="login-btn" id="loginBtn">Sign In</button>
    </form>

    <div class="signup-link">
        <p>Don't have an account? <a href="signup.jsp">Create one here</a></p>
    </div>
</div>

<script src="js/login.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>