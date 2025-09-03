<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SynFlow</title>
  <link rel="stylesheet" href="style.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet" />
</head>
<body>
  <div class="header">
    <h1 class="brand">SynFlow</h1>
    <p class="tagline">Connecting departments at MIT-ADT for a seamless communication flow.</p>
  </div>

  <div class="auth-box">
    <div class="auth-tabs">
      <div class="auth-tab active" onclick="showForm('login')">Login</div>
      <div class="auth-tab" onclick="showForm('register')">Register</div>
    </div>

    <!-- Login Form -->
    <div class="form-area active" id="loginForm">
      <form action="LoginServlet" method="post">
        <input type="email" name="email" placeholder="Email" required />
        <div class="password-wrapper">
          <input type="password" name="password" id="loginPassword" placeholder="Password" required />
          <span class="toggle-eye" id="loginEye" onclick="togglePassword('loginPassword', 'loginEye')">👁</span>
        </div>
        <button type="submit">Login</button>
      </form>

      <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
          <%= request.getAttribute("errorMessage") %>
        </div>
      <% } %>

      <div class="social-login">
        <p>Or login with</p>
        <div class="social-btns">
          <form action="GoogleLoginServlet" method="post"><button class="google-btn">Google</button></form>
          <form action="FacebookLoginServlet" method="post"><button class="fb-btn">Facebook</button></form>
        </div>
      </div>
    </div>

    <!-- Register Form -->
    <div class="form-area" id="registerForm">
      <form action="RegisterServlet" method="post" onsubmit="return validateEmail()">
        <input type="text" name="fullname" placeholder="Full Name" required />
        <input type="email" name="email" id="registerEmail" placeholder="Email" required />
        <div class="password-wrapper">
          <input type="password" name="password" id="registerPassword" placeholder="Password" required />
          <span class="toggle-eye" id="registerEye" onclick="togglePassword('registerPassword', 'registerEye')">👁</span>
        </div>
        <select name="role" required>
          <option value="">Select Role</option>
          <option value="student">Student</option>
          <option value="faculty">Faculty</option>
        </select>
        <button type="submit">Register</button>
      </form>
    </div>
  </div>

  <footer>
    © 2025 SynFlow | MIT-ADT University
  </footer>

  <script>
    function showForm(type) {
      const loginForm = document.getElementById('loginForm');
      const registerForm = document.getElementById('registerForm');
      const tabs = document.querySelectorAll('.auth-tab');

      if (type === 'login') {
        loginForm.classList.add('active');
        registerForm.classList.remove('active');
        tabs[0].classList.add('active');
        tabs[1].classList.remove('active');
      } else {
        loginForm.classList.remove('active');
        registerForm.classList.add('active');
        tabs[0].classList.remove('active');
        tabs[1].classList.add('active');
      }
    }

    function togglePassword(inputId, eyeId) {
      const input = document.getElementById(inputId);
      const eye = document.getElementById(eyeId);
      if (input.type === "password") {
        input.type = "text";
        eye.textContent = "🙈‍🗨";
      } else {
        input.type = "password";
        eye.textContent = "👁";
      }
    }

    // Email validation for registration
    function validateEmail() {
      const email = document.getElementById("registerEmail").value;
      const regex = /^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com)$/;
      if (!regex.test(email)) {
        alert("Please enter a valid email address.");
        return false;
      }
      return true;
    }
  </script>
</body>
</html>