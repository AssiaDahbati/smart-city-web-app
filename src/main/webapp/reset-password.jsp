<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();

  String token = request.getParameter("token");
  if (token == null) token = "";

  String err = request.getParameter("error");
  String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Reset Password - SmartCity</title>

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
      user-select:none;
      pointer-events:none;
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

    /* circle decoration like login */
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

    .cardx{
      width:100%;
      max-width:440px;
      background:#fff;
      border-radius:18px;
      box-shadow:0 18px 40px rgba(0,0,0,.18);
      padding:26px;
      position:relative;
      z-index:2;
    }

    /* HOME button */
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

    .title{
      font-weight:900;
      font-size:34px;
      margin:18px 0 6px;
      color:#111827;
      display:flex;
      align-items:center;
      gap:10px;
    }
    .subtitle{
      color:#6b7280;
      font-weight:700;
      margin-bottom:18px;
      line-height:1.35;
    }

    .alertx{
      border-radius:14px;
      font-weight:800;
      margin-bottom:14px;
    }

    .field{
      position:relative;
      margin-bottom:16px;
    }
    .field .icon-left{
      position:absolute;
      left:16px;
      top:50%;
      transform:translateY(-50%);
      color:#9ca3af;
    }
    .input{
      width:100%;
      padding:14px 48px 14px 44px;
      border-radius:999px;
      border:1px solid #e5e7eb;
      font-weight:700;
      outline:none;
    }
    .input:focus{
      border-color:#93c5fd;
      box-shadow:0 0 0 4px rgba(147,197,253,.35);
    }

    .eye-btn{
      position:absolute;
      right:10px;
      top:50%;
      transform:translateY(-50%);
      border:0;
      background:transparent;
      width:40px;
      height:40px;
      border-radius:10px;
      color:#6b7280;
    }
    .eye-btn:hover{ background:#f3f4f6; }

    .btn-primaryx{
      width:100%;
      padding:14px;
      border-radius:999px;
      border:0;
      background:#0B73E7;
      color:#fff;
      font-weight:900;
      box-shadow:0 12px 24px rgba(11,115,231,.32);
    }
    .btn-primaryx:hover{ filter:brightness(.97); }

    .btn-back{
      width:100%;
      padding:14px;
      border-radius:999px;
      border:1px solid #e5e7eb;
      background:#fff;
      color:#111827;
      font-weight:900;
      margin-top:10px;
      text-decoration:none;
      display:flex;
      align-items:center;
      justify-content:center;
      gap:10px;
    }
    .btn-back:hover{ background:#f9fafb; }

    .note{
      margin-top:10px;
      text-align:center;
      color:#6b7280;
      font-weight:700;
      font-size:12px;
    }

    @media (max-width: 992px){
      .page{ flex-direction:column; }
      .right{ border-radius:0; }
      .left{ padding:26px; }
    }
  </style>
</head>

<body>
<div class="page">

  <!-- LEFT -->
  <div class="left">
    <img src="<%= ctx %>/uploads/reset.avif" alt="Reset Illustration">
  </div>

  <!-- RIGHT -->
  <div class="right">
    <div class="cardx">

      <a href="<%= ctx %>/HomeServlet" class="home-btn">
        <i class="fa-solid fa-house me-1"></i> Home
      </a>

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

      <h1 class="title">
        <i class="fa-solid fa-key"></i>
        Reset Password
      </h1>
      <p class="subtitle">Enter a new password for your account.</p>

      <form method="post" action="<%= ctx %>/ResetPasswordServlet">
        <input type="hidden" name="token" value="<%= token %>">

        <div class="field">
          <i class="fa-solid fa-lock icon-left"></i>
          <input id="pass1" class="input" type="password" name="password"
                 placeholder="New Password" required minlength="6">
          <button type="button" class="eye-btn" onclick="togglePass('pass1', this)">
            <i class="fa-regular fa-eye"></i>
          </button>
        </div>

        <div class="field">
          <i class="fa-solid fa-shield-halved icon-left"></i>
          <input id="pass2" class="input" type="password" name="confirm"
                 placeholder="Confirm Password" required minlength="6">
          <button type="button" class="eye-btn" onclick="togglePass('pass2', this)">
            <i class="fa-regular fa-eye"></i>
          </button>
        </div>

        <button class="btn-primaryx" type="submit">
          Update Password
        </button>

        <a class="btn-back" href="<%= ctx %>/login.jsp">
          <i class="fa-solid fa-arrow-left"></i> Back to Login
        </a>

        <div class="note">Password must be at least 6 characters.</div>
      </form>

    </div>
  </div>

</div>

<script>
  function togglePass(id, btn){
    const input = document.getElementById(id);
    const icon = btn.querySelector("i");
    if (input.type === "password"){
      input.type = "text";
      icon.className = "fa-regular fa-eye-slash";
    } else {
      input.type = "password";
      icon.className = "fa-regular fa-eye";
    }
  }
</script>

</body>
</html>
