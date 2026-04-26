<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    String u = (String) session.getAttribute("username");
    if (u == null) u = "admin";


    Boolean showWelcome = (Boolean) session.getAttribute("showWelcome");
    if (showWelcome == null) showWelcome = false;
    session.setAttribute("showWelcome", false); 
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>SmartCity Dashboard</title>


  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">


  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
    body { background:#f6f7fb; font-family: system-ui, Arial, sans-serif; }

   
    .sidebar{
      width: 250px;
      background:#ffffff;
      min-height:100vh;
      position: fixed;
      border-right:1px solid #e5e7eb;
      padding:18px 0;
    }

    .brand{
      padding:0 18px 16px;
      display:flex;
      align-items:center;
      gap:12px;
    }
    .logo{
      width:46px;height:46px;
      border-radius:14px;
      background:#3b82f6;
      color:#fff;
      display:flex;
      align-items:center;
      justify-content:center;
      font-weight:900;
    }
    .nav-link{
      padding:12px 18px;
      display:flex;
      align-items:center;
      gap:12px;
      font-weight:600;
      color:#374151;
      border-left:4px solid transparent;
      text-decoration:none;
    }
    .nav-link:hover,
    .nav-link.active{
      background:#eef2ff;
      border-left-color:#3b82f6;
      color:#111827;
    }


    .main{ margin-left:250px; }

    .topbar{
      background:#fff;
      border-bottom:1px solid #e5e7eb;
      padding:18px 24px;
      display:flex;
      justify-content:space-between;
      align-items:center;
    }
    .title-wrap{
      display:flex;
      align-items:center;
      gap:10px;
    }
    .dashboard-title{
      font-size:26px;
      font-weight:900;
      color:#111827;
      margin:0;
    }

    .online-badge{
      font-size:10px;
      font-weight:800;
      padding:4px 8px;
      border-radius:999px;
      background:#4ade80;   
      color:#064e3b;       
      letter-spacing:.5px;
      line-height:1;
      animation: pulseGreen 2s infinite;
    }

    @keyframes pulseGreen {
      0% { box-shadow: 0 0 0 0 rgba(74, 222, 128, 0.7); }
      70% { box-shadow: 0 0 0 10px rgba(74, 222, 128, 0); }
      100% { box-shadow: 0 0 0 0 rgba(74, 222, 128, 0); }
    }

  
    .cards-area{ padding:30px; }

    .dash-card{
      height:220px;              
      border-radius:20px;
      display:flex;
      align-items:center;
      justify-content:center;
      color:#fff;
      text-decoration:none;
      box-shadow:0 16px 35px rgba(0,0,0,.12);
      transition:.2s;
      position:relative;
      overflow:hidden;
    }
    .dash-card:hover{ transform:translateY(-5px); }


    .dash-card::before{
      content:"";
      position:absolute;
      width:260px;
      height:260px;
      background:#fff;
      opacity:.18;
      border-radius:80px;
      top:-90px;
      right:-90px;
      pointer-events:none;
    }

    
    .dash-card::after{
      content:"";
      position:absolute;
      inset:0;
      background: rgba(255,255,255,0.00);
      backdrop-filter: blur(0px);
      -webkit-backdrop-filter: blur(0px);
      transition:.2s;
      pointer-events:none;
    }
    .dash-card:hover::after{
      background: rgba(255,255,255,0.28);
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
    }

    .card-content{
      text-align:center;
      z-index:2;
    }
    .icon{
      font-size:60px;
      margin-bottom:12px;
      transition:.2s;
    }
    
    .dash-card:hover .icon{ color:#111827; }
    .label{
      font-size:22px;
      font-weight:900;
      transition:.2s;
    }

    
    .c-students { background:#3b82f6; }  /* blue */
    .c-tourism  { background:#f59e0b; }  /* hot yellow */
    .c-jobs     { background:#ef4444; }  /* red */
    .c-business { background:#22c55e; }  /* green */
    .c-users    { background:#111827; }  /* dark for users */

    /* Toast position */
    .toast-wrap{
      position: fixed;
      top: 18px;
      right: 18px;
      z-index: 9999;
    }
  </style>
</head>

<body>

<!-- Welcome Toast -->
<div class="toast-wrap">
  <div id="welcomeToast" class="toast align-items-center text-bg-dark border-0" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="d-flex">
      <div class="toast-body">
        Welcome, <strong><%= u %></strong> 👋
      </div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
  </div>
</div>

<!-- Sidebar -->
<div class="sidebar">
  <div class="brand">
    <div class="logo">SC</div>
    <div>
      <strong>SmartCity</strong><br>
      <small class="text-muted">Admin Panel</small>
    </div>
  </div>

  <a class="nav-link active" href="admin.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a>
  <a class="nav-link" href="StudentServlet"><i class="fa-solid fa-user-graduate"></i> Students</a>
  <a class="nav-link" href="TourismServlet"><i class="fa-solid fa-umbrella-beach"></i> Tourism</a>
  <a class="nav-link" href="JobServlet"><i class="fa-solid fa-briefcase"></i> Jobs</a>
  <a class="nav-link" href="BusinessServlet"><i class="fa-solid fa-building"></i> Business</a>

  <!-- ✅ Manage Users -->
  <a class="nav-link" href="<%= request.getContextPath() %>/AdminUserServlet">
    <i class="fa-solid fa-users-gear"></i> Manage Users
  </a>

  <hr>
  <a class="nav-link" href="LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<!-- Main -->
<div class="main">
  <div class="topbar">
    <div class="title-wrap">
      <h1 class="dashboard-title">Dashboard</h1>
      <span class="online-badge">ONLINE</span>
    </div>

    <div class="text-muted"><i class="fa-regular fa-circle-user"></i> <%= u %></div>
  </div>

  <!-- Cards -->
  <div class="cards-area">
    <div class="row g-4">

      <div class="col-12 col-md-6">
        <a class="dash-card c-students" href="StudentServlet">
          <div class="card-content">
            <div class="icon"><i class="fa-solid fa-user-graduate"></i></div>
            <div class="label">Students</div>
          </div>
        </a>
      </div>

      <div class="col-12 col-md-6">
        <a class="dash-card c-tourism" href="TourismServlet">
          <div class="card-content">
            <div class="icon"><i class="fa-solid fa-umbrella-beach"></i></div>
            <div class="label">Tourism</div>
          </div>
        </a>
      </div>

      <div class="col-12 col-md-6">
        <a class="dash-card c-jobs" href="JobServlet">
          <div class="card-content">
            <div class="icon"><i class="fa-solid fa-briefcase"></i></div>
            <div class="label">Jobs</div>
          </div>
        </a>
      </div>

      <div class="col-12 col-md-6">
        <a class="dash-card c-business" href="BusinessServlet">
          <div class="card-content">
            <div class="icon"><i class="fa-solid fa-building"></i></div>
            <div class="label">Business</div>
          </div>
        </a>
      </div>

      <!-- ✅ Manage Users Card -->
      <div class="col-12 col-md-6">
        <a class="dash-card c-users" href="<%= request.getContextPath() %>/AdminUserServlet">
          <div class="card-content">
            <div class="icon"><i class="fa-solid fa-users-gear"></i></div>
            <div class="label">Users</div>
          </div>
        </a>
      </div>

    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Show welcome toast only if session flag says so
  const shouldShow = <%= showWelcome ? "true" : "false" %>;
  if (shouldShow) {
    const toastEl = document.getElementById('welcomeToast');
    const t = new bootstrap.Toast(toastEl, { delay: 2500 });
    t.show();
  }
</script>

</body>
</html>
