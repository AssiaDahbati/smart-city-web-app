<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();

  // support BOTH: request attribute OR query param
  String err = (String) request.getAttribute("error");
  if (err == null || err.trim().isEmpty()) {
    err = request.getParameter("error");
  }

  String msg = request.getParameter("msg"); // optional

  // session flash (from ForgotPasswordServlet or others)
  String flash = (String) session.getAttribute("flash");
  if (flash != null) session.removeAttribute("flash");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Admin Login - SmartCity</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
    body{
      margin:0;
      min-height:100vh;
      font-family:system-ui, Arial, sans-serif;
      background:#ffffff;
    }

    .page{
      min-height:100vh;
      display:flex;
      overflow:hidden;
    }

    /* LEFT */
    .left{
      flex:1.05;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:48px;
      background:#fff;
    }
    .left img{
      max-width:520px;
      width:100%;
      height:auto;
    }

    /* RIGHT */
    .right{
      flex:.95;
      background:#0B73E7;
      position:relative;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:48px 30px;
      border-top-left-radius:46px;
      border-bottom-left-radius:46px;
    }

    .right::after{
      content:"";
      position:absolute;
      right:-120px;
      bottom:-120px;
      width:380px;
      height:380px;
      border-radius:50%;
      border:2px solid rgba(255,255,255,.55);
      box-shadow:0 0 0 26px rgba(255,255,255,.10);
      opacity:.75;
      pointer-events:none;
    }

    .login-card{
      width:100%;
      max-width:440px;
      background:#fff;
      border-radius:18px;
      box-shadow:0 18px 40px rgba(0,0,0,.18);
      padding:26px;
      position:relative;
      z-index:2;
    }

    /* HOME BUTTON */
    .home-btn{
      position:absolute;
      top:18px;
      right:18px;
      border-radius:999px;
      padding:8px 14px;
      font-weight:800;
      border:0;
      background:#111827;
      color:#fff;
      text-decoration:none;
      font-size:13px;
    }
    .home-btn:hover{ filter:brightness(.95); color:#fff; }

    .hello{
      font-weight:900;
      font-size:34px;
      margin:18px 0 6px;
      color:#111827;
    }
    .subtitle{
      color:#6b7280;
      font-weight:700;
      margin-bottom:18px;
    }

    .field{
      position:relative;
      margin-bottom:16px;
    }
    .field i{
      position:absolute;
      left:16px;
      top:50%;
      transform:translateY(-50%);
      color:#9ca3af;
    }
    .input{
      width:100%;
      padding:14px 14px 14px 44px;
      border-radius:999px;
      border:1px solid #e5e7eb;
      font-weight:700;
    }

    .btn-login{
      width:100%;
      padding:14px;
      border-radius:999px;
      border:0;
      background:#0B73E7;
      color:#fff;
      font-weight:900;
      box-shadow:0 12px 24px rgba(11,115,231,.32);
    }

    .alertx{
      border-radius:14px;
      font-weight:700;
      margin-bottom:14px;
    }

    /* remember + forgot row */
    .row2{
      display:flex;
      align-items:center;
      justify-content:space-between;
      margin:6px 2px 14px;
    }
    .remember{
      display:flex;
      align-items:center;
      gap:8px;
      color:#374151;
      font-weight:800;
      font-size:13px;
      user-select:none;
    }
    .remember input{
      width:16px; height:16px;
      accent-color:#0B73E7;
    }

    /* smaller forgot password */
    .forgot{
      font-size:12px;
      font-weight:700;
      color:#6b7280;
      text-decoration:none;
    }
    .forgot:hover{ color:#111827; }

    @media (max-width: 992px){
      .page{ flex-direction:column; }
      .right{ border-radius:0; }
    }
  </style>
</head>

<body>

<div class="page">

  <!-- LEFT -->
  <div class="left">
    <img src="<%= ctx %>/uploads/admin.jpg" alt="Admin Illustration">
  </div>

  <!-- RIGHT -->
  <div class="right">
    <div class="login-card">

      <!-- HOME BUTTON (use servlet, not index.jsp) -->
      <a href="<%= ctx %>/HomeServlet" class="home-btn">
        <i class="fa-solid fa-house me-1"></i> Home
      </a>

      <% if (flash != null && !flash.trim().isEmpty()) { %>
        <div class="alert alert-success alertx">
          <i class="fa-solid fa-circle-check me-2"></i><%= flash %>
        </div>
      <% } %>

      <% if (msg != null && !msg.trim().isEmpty()) { %>
        <div class="alert alert-success alertx">
          <i class="fa-solid fa-circle-check me-2"></i><%= msg %>
        </div>
      <% } %>

      <% if (err != null && !err.trim().isEmpty()) { %>
        <div class="alert alert-danger alertx">
          <i class="fa-solid fa-triangle-exclamation me-2"></i><%= err %>
        </div>
      <% } %>

      <h1 class="hello">Hello!</h1>
      <p class="subtitle">Sign in to get started</p>

      <form id="loginForm" method="post" action="<%= ctx %>/login">

        <div class="field">
          <i class="fa-regular fa-envelope"></i>
          <input id="username" class="input" type="text" name="username" placeholder="Username" required>
        </div>

        <div class="field">
          <i class="fa-solid fa-lock"></i>
          <input class="input" type="password" name="password" placeholder="Password" required>
        </div>

        <!-- Remember + Forgot -->
        <div class="row2">
          <label class="remember">
            <!-- name="remember" so servlet can read it -->
            <input id="rememberMe" type="checkbox" name="remember" value="1">
            Remember me
          </label>

          <!-- opens modal -->
          <a class="forgot" href="#" data-bs-toggle="modal" data-bs-target="#forgotModal">
            Forgot Password?
          </a>
        </div>

        <button class="btn-login" type="submit">Login</button>
      </form>

    </div>
  </div>

</div>

<!-- Forgot Password Modal -->
<div class="modal fade" id="forgotModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="border-radius:18px;">
      <div class="modal-header">
        <h5 class="modal-title fw-bold">
          <i class="fa-solid fa-unlock-keyhole me-2"></i>Forgot Password
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

<form method="post" action="<%= ctx %>/ForgotPasswordServlet">

        <div class="modal-body">
          <p class="text-muted fw-bold mb-2">
            Enter your email. If an account exists, admin will handle the reset.
          </p>

          <label class="fw-bold mb-1">Email</label>
          <input class="form-control" type="email" name="email" required
                 placeholder="you@email.com"
                 style="border-radius:14px; font-weight:700;">
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-light fw-bold" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-primary fw-bold">Send Request</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  // Remember me (localStorage)
  const usernameInput = document.getElementById("username");
  const rememberMe = document.getElementById("rememberMe");
  const form = document.getElementById("loginForm");

  const savedUser = localStorage.getItem("smartcity_username");
  const savedRemember = localStorage.getItem("smartcity_remember");

  if (savedRemember === "1" && savedUser) {
    usernameInput.value = savedUser;
    rememberMe.checked = true;
  }

  form.addEventListener("submit", function () {
    if (rememberMe.checked) {
      localStorage.setItem("smartcity_username", usernameInput.value);
      localStorage.setItem("smartcity_remember", "1");
    } else {
      localStorage.removeItem("smartcity_username");
      localStorage.removeItem("smartcity_remember");
    }
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
