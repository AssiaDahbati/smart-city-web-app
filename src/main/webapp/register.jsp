<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String msg = (String) request.getAttribute("msg");     // optional success message
  String err = (String) request.getAttribute("error");   // optional error message
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Register - SmartCity</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
    body{
      margin:0;
      min-height:100vh;
      font-family:system-ui, Arial, sans-serif;
      background:#f5f7ff;
    }

    .page{
      min-height:100vh;
      display:flex;
      align-items:stretch;
      overflow:hidden;
    }

    /* LEFT ILLUSTRATION */
    .left{
      flex:1.1;
      background: radial-gradient(circle at 20% 20%, rgba(255,255,255,.25), transparent 55%),
                  radial-gradient(circle at 80% 30%, rgba(255,255,255,.18), transparent 60%),
                  #6C7BFF;
      position:relative;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:48px 34px;
      color:#fff;
    }

    .left-inner{
      max-width:520px;
      width:100%;
    }

    .left-badge{
      display:inline-flex;
      gap:10px;
      align-items:center;
      font-weight:900;
      padding:10px 14px;
      border-radius:999px;
      background: rgba(255,255,255,.18);
      border: 1px solid rgba(255,255,255,.25);
    }

    .left-title{
      margin:22px 0 12px;
      font-weight:1000;
      font-size:44px;
      line-height:1.05;
      letter-spacing:-.6px;
    }

    .left-sub{
      font-weight:700;
      opacity:.92;
      max-width:44ch;
    }

    .illu{
      margin-top:28px;
      background: rgba(255,255,255,.18);
      border: 1px solid rgba(255,255,255,.25);
      border-radius:22px;
      padding:16px;
      display:flex;
      justify-content:center;
      align-items:center;
    }
    .illu img{
      width:100%;
      max-width:420px;
      height:auto;
      display:block;
      border-radius:16px;
    }

    /* RIGHT FORM */
    .right{
      flex:.9;
      background:#f5f7ff;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:48px 24px;
      position:relative;
    }

    .cardx{
      width:100%;
      max-width:520px;
      background: rgba(255,255,255,.92);
      border:1px solid rgba(229,231,235,.9);
      border-radius:24px;
      box-shadow:0 22px 50px rgba(17,24,39,.12);
      padding:28px;
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      position:relative;
    }

    .top-actions{
      position:absolute;
      top:18px;
      right:18px;
      display:flex;
      gap:10px;
    }

    .smallbtn{
      border:0;
      padding:10px 12px;
      border-radius:999px;
      font-weight:900;
      font-size:12px;
      text-decoration:none;
      display:inline-flex;
      gap:8px;
      align-items:center;
    }
    .btn-home{ background:#111827; color:#fff; }
    .btn-home:hover{ filter:brightness(.95); color:#fff; }
    .btn-login{ background:rgba(108,123,255,.12); color:#2b3cff; border:1px solid rgba(108,123,255,.35); }
    .btn-login:hover{ background:rgba(108,123,255,.16); color:#2b3cff; }

    .h1{
      margin-top:26px;
      font-weight:1000;
      font-size:34px;
      letter-spacing:-.3px;
      color:#111827;
    }
    .sub{
      color:#6b7280;
      font-weight:700;
      margin-top:6px;
      margin-bottom:18px;
    }

    .alertx{
      border-radius:16px;
      font-weight:800;
    }

    .field{
      margin-bottom:14px;
    }
    label{
      font-weight:900;
      color:#111827;
      margin-bottom:8px;
    }

    .input{
      border-radius:16px;
      padding:12px 14px;
      border:1px solid #e5e7eb;
      background:#fff;
      font-weight:700;
    }
    .input:focus{
      box-shadow:0 0 0 4px rgba(108,123,255,.18);
      border-color: rgba(108,123,255,.55);
    }

    .row2{
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;
      margin:8px 0 14px;
      flex-wrap:wrap;
    }
    .agree{
      display:flex;
      align-items:flex-start;
      gap:10px;
      font-weight:800;
      color:#374151;
      font-size:13px;
      user-select:none;
      max-width: 100%;
    }
    .agree input{
      width:16px;height:16px;
      margin-top:2px;
      accent-color:#6C7BFF;
    }
    .agree a{
      color:#2b3cff;
      text-decoration:none;
      font-weight:900;
    }
    .agree a:hover{ text-decoration:underline; }

    .btn-signup{
      width:100%;
      border:0;
      border-radius:999px;
      padding:14px 16px;
      font-weight:1000;
      color:#fff;
      background: linear-gradient(135deg, #6C7BFF, #5563FF);
      box-shadow:0 16px 30px rgba(85,99,255,.30);
    }
    .btn-signup:hover{ filter:brightness(.98); }

    .or{
      text-align:center;
      color:#6b7280;
      font-weight:900;
      margin:18px 0 12px;
      position:relative;
    }
    .or:before, .or:after{
      content:"";
      position:absolute;
      top:50%;
      width:42%;
      height:1px;
      background:#e5e7eb;
    }
    .or:before{ left:0; }
    .or:after{ right:0; }

    .socials{
      display:flex;
      justify-content:center;
      gap:12px;
      margin-bottom:10px;
    }
    .soc{
      width:44px;height:44px;
      border-radius:999px;
      display:flex;
      align-items:center;
      justify-content:center;
      background:#fff;
      border:1px solid #e5e7eb;
      color:#111827;
      text-decoration:none;
    }
    .soc:hover{ background:#f3f4f6; }

    .foot{
      text-align:center;
      font-weight:800;
      margin-top:10px;
      color:#374151;
    }
    .foot a{
      color:#2b3cff;
      font-weight:1000;
      text-decoration:none;
    }
    .foot a:hover{ text-decoration:underline; }

    @media (max-width: 992px){
      .page{ flex-direction:column; }
      .left{ min-height: 360px; }
      .left-title{ font-size:36px; }
    }
  </style>
</head>

<body>
<div class="page">

  <!-- LEFT PANEL -->
  <div class="left">
    <div class="left-inner">
      <div class="left-badge">
        <i class="fa-solid fa-school"></i>
        SmartCity
      </div>

      <div class="left-title">
        Learn From World’s Best Instructors 🌍
      </div>

      <div class="left-sub">
        Create your account to explore tourism, jobs, business, and educational places.
      </div>

      <div class="illu">

        <img src="<%= ctx %>/uploads/register-illustration.webp" alt="Illustration">
      </div>
    </div>
  </div>

  <!-- RIGHT FORM -->
  <div class="right">
    <div class="cardx">

      <div class="top-actions">
        <a class="smallbtn btn-home" href="<%= ctx %>/HomeServlet">
          <i class="fa-solid fa-house"></i> Home
        </a>
        <a class="smallbtn btn-login" href="<%= ctx %>/login.jsp">
          <i class="fa-solid fa-right-to-bracket"></i> Login
        </a>
      </div>

      <% if (err != null) { %>
        <div class="alert alert-danger alertx">
          <i class="fa-solid fa-triangle-exclamation me-2"></i><%= err %>
        </div>
      <% } %>

      <% if (msg != null) { %>
        <div class="alert alert-success alertx">
          <i class="fa-solid fa-circle-check me-2"></i><%= msg %>
        </div>
      <% } %>

      <div class="h1">Create Account</div>
     

      <form method="post" action="<%= ctx %>/register">
        <div class="field">
          <label>Username</label>
          <input class="form-control input" type="text" name="username" required placeholder="Your username">
        </div>

        <div class="field">
          <label>Email Address</label>
          <input class="form-control input" type="email" name="email" required placeholder="you@email.com">
        </div>

        <div class="field">
          <label>Password</label>
          <div class="position-relative">
            <input id="pass" class="form-control input pe-5" type="password" name="password" required placeholder="••••••••">
            <button type="button"
                    class="btn position-absolute top-50 end-0 translate-middle-y me-2"
                    style="border:0;background:transparent;color:#6b7280;"
                    onclick="togglePass()">
              <i id="eye" class="fa-regular fa-eye"></i>
            </button>
          </div>
        </div>

        <div class="row2">
          <label class="agree">
            <input id="agree" type="checkbox" required>
            <span>
              I agree to the <a href="#" onclick="return false;">terms of service</a>
              and <a href="#" onclick="return false;">privacy policy</a>
            </span>
          </label>
        </div>

        <button class="btn-signup" type="submit">Sign Up</button>

        <div class="or">Or Sign Up With</div>

        <!-- Just UI (no real OAuth) -->
        <div class="socials">
          <a class="soc" href="#" onclick="return false;" title="Google"><i class="fa-brands fa-google"></i></a>
          <a class="soc" href="#" onclick="return false;" title="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
          <a class="soc" href="#" onclick="return false;" title="Instagram"><i class="fa-brands fa-instagram"></i></a>
          <a class="soc" href="#" onclick="return false;" title="Twitter"><i class="fa-brands fa-x-twitter"></i></a>
          <a class="soc" href="#" onclick="return false;" title="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
        </div>

        <div class="foot">
          Already have an account? <a href="<%= ctx %>/login.jsp">Sign in</a>
        </div>
      </form>
    </div>
  </div>

</div>

<script>
  function togglePass(){
    const p = document.getElementById("pass");
    const e = document.getElementById("eye");
    if(p.type === "password"){
      p.type = "text";
      e.className = "fa-regular fa-eye-slash";
    }else{
      p.type = "password";
      e.className = "fa-regular fa-eye";
    }
  }
</script>
</body>
</html>
