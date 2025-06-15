<%--
  Created by IntelliJ IDEA.
  User: Nethushi
  Date: 6/13/2025
  Time: 3:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Complaint</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            color: #e0e0e0;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        /* Header */
        .header {
            background: rgba(30, 30, 30, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 140, 0, 0.2);
            padding: 20px 0;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            margin: -20px -20px 30px -20px;
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo-icon {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
            color: #000;
            box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
        }

        .logo-text {
            font-size: 24px;
            font-weight: 700;
            color: #ff8c00;
            text-shadow: 0 0 10px rgba(255, 140, 0, 0.3);
        }

        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #ff8c00;
            text-decoration: none;
            font-weight: 600;
            padding: 10px 15px;
            border-radius: 8px;
            background: rgba(255, 140, 0, 0.1);
            border: 1px solid rgba(255, 140, 0, 0.3);
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: rgba(255, 140, 0, 0.2);
            transform: translateX(-5px);
        }

        .form-container {
            background: rgba(40, 40, 40, 0.8);
            border-radius: 15px;
            padding: 30px;
            border: 1px solid rgba(255, 140, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: #ff8c00;
        }

        .form-header {
            margin-bottom: 30px;
        }

        .form-title {
            font-size: 20px;
            font-weight: 600;
            color: #ff8c00;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .form-description {
            color: #b0b0b0;
            font-size: 14px;
            line-height: 1.5;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #e0e0e0;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-group .required {
            color: #ff8c00;
        }

        .form-control {
            width: 100%;
            background: rgba(60, 60, 60, 0.8);
            border: 1px solid rgba(255, 140, 0, 0.3);
            border-radius: 8px;
            color: #e0e0e0;
            padding: 12px 15px;
            font-size: 14px;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-control:focus {
            outline: none;
            border-color: #ff8c00;
            box-shadow: 0 0 0 3px rgba(255, 140, 0, 0.1);
            background: rgba(70, 70, 70, 0.9);
        }

        .form-control::placeholder {
            color: #888;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }

        .priority-options {
            display: flex;
            gap: 15px;
            margin-top: 8px;
            flex-wrap: wrap;
        }

        .priority-option {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .priority-option input[type="radio"] {
            width: 18px;
            height: 18px;
            accent-color: #ff8c00;
        }

        .priority-option label {
            margin: 0;
            color: #c0c0c0;
            font-size: 14px;
            cursor: pointer;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 140, 0, 0.2);
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            min-width: 120px;
            justify-content: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            color: #000;
            box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 140, 0, 0.5);
        }

        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .btn-secondary {
            background: rgba(108, 117, 125, 0.2);
            color: #6c757d;
            border: 1px solid rgba(108, 117, 125, 0.3);
        }

        .btn-secondary:hover {
            background: rgba(108, 117, 125, 0.3);
            transform: translateY(-1px);
        }

        .form-help {
            background: rgba(0, 123, 255, 0.1);
            border: 1px solid rgba(0, 123, 255, 0.3);
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
        }

        .form-help-title {
            color: #007bff;
            font-weight: 600;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-help-text {
            color: #b0b0b0;
            font-size: 14px;
            line-height: 1.5;
        }

        .form-help ul {
            margin: 10px 0 0 20px;
            color: #b0b0b0;
        }

        .form-help li {
            margin-bottom: 5px;
        }

        .char-counter {
            text-align: right;
            font-size: 12px;
            color: #888;
            margin-top: 5px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .header {
                margin: -10px -10px 20px -10px;
            }

            .header-content {
                padding: 0 10px;
                flex-direction: column;
                gap: 15px;
            }

            .logo-text {
                font-size: 20px;
            }

            .form-container {
                padding: 20px;
            }

            .priority-options {
                flex-direction: column;
                gap: 10px;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        /* Custom scrollbar */
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
<!-- Header -->
<header class="header">
    <div class="header-content">
        <div class="logo">
            <div class="logo-icon">E</div>
            <div class="logo-text">Employee Portal</div>
        </div>
        <a href="employeeDashboard.jsp" class="back-link">
            ← Back to Dashboard
        </a>
    </div>
</header>

<!-- Form Container -->
        <div class="form-header">
            <h3 class="form-title">
                📋 New Complaint Form
            </h3>
            <p class="form-description">
                Please provide detailed information about your complaint. All fields marked with <span class="required">*</span> are required.
            </p>
        </div>

        <!-- Help Section -->
        <div class="form-help">
            <div class="form-help-title">
                💡 Tips for Better Resolution
            </div>
            <div class="form-help-text">
                <ul>
                    <li>Be specific about dates, times, and locations</li>
                    <li>Include relevant reference numbers or IDs</li>
                    <li>Describe the issue clearly and concisely</li>
                    <li>Mention any previous attempts to resolve the issue</li>
                </ul>
            </div>
        </div>

        <!-- Complaint Form -->
        <form action="submitComplaint" method="post" id="complaintForm">
            <div class="form-group">
                <label for="title">Complaint Title <span class="required">*</span></label>
                <input type="text"
                       id="title"
                       name="title"
                       class="form-control"
                       placeholder="Enter a brief summary of your complaint"
                       required>
            </div>

            <div class="form-group">
                <label for="description">Detailed Description <span class="required">*</span></label>
                <textarea id="description"
                          name="description"
                          class="form-control"
                          placeholder="Please provide a detailed description of your complaint. Include relevant dates, times, locations, and any other important information that will help us understand and resolve your issue."
                          required></textarea>
            </div>

            <div class="form-group">
                <label>Priority <span class="required">*</span></label>
                <div class="priority-options">
                    <div class="priority-option">
                        <input type="radio" id="priorityHigh" name="priority" value="high" required>
                        <label for="priorityHigh">High</label>
                    </div>
                    <div class="priority-option">
                        <input type="radio" id="priorityMedium" name="priority" value="medium">
                        <label for="priorityMedium">Medium</label>
                    </div>
                    <div class="priority-option">
                        <input type="radio" id="priorityLow" name="priority" value="low">
                        <label for="priorityLow">Low</label>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    📤 Submit Complaint
                </button>
            </div>
        </form>


<script src="js/submitComplaint.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>