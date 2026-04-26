<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="models.Tourism" %>
<%@ page import="models.Job" %>
<%@ page import="models.Business" %>
<%@ page import="models.Student" %>
<%@ page import="models.User" %>

<%
  String ctx = request.getContextPath();

  // Logged visitor
  User loggedUser = (User) session.getAttribute("user");

  // Lists
  List<Tourism> tourismList = (List<Tourism>) request.getAttribute("tourismList");
  List<Job> jobList = (List<Job>) request.getAttribute("jobList");
  List<Business> businessList = (List<Business>) request.getAttribute("businessList");
  List<Student> eduList = (List<Student>) request.getAttribute("eduList");

  if (tourismList == null) tourismList = new ArrayList<>();
  if (jobList == null) jobList = new ArrayList<>();
  if (businessList == null) businessList = new ArrayList<>();
  if (eduList == null) eduList = new ArrayList<>();

  // Counts
  Integer studentsCount = (Integer) request.getAttribute("studentsCount");
  Integer tourismCount  = (Integer) request.getAttribute("tourismCount");
  Integer jobsCount     = (Integer) request.getAttribute("jobsCount");
  Integer businessCount = (Integer) request.getAttribute("businessCount");

  if (studentsCount == null) studentsCount = 0;
  if (tourismCount == null) tourismCount = 0;
  if (jobsCount == null) jobsCount = 0;
  if (businessCount == null) businessCount = 0;
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>SmartCity - Home</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
    body{
      font-family: system-ui, Arial, sans-serif;
      margin:0;
      min-height:100vh;
      color:#111827;
      background:#f7f7fb;
      overflow-x:hidden;
    }

    /* BLUR BLUE BACKGROUND */
    .blur-bg{
      position:fixed;
      inset:0;
      z-index:-1;
      background:
        radial-gradient(circle at 15% 20%, rgba(59,130,246,.45), transparent 55%),
        radial-gradient(circle at 85% 30%, rgba(96,165,250,.30), transparent 55%),
        radial-gradient(circle at 50% 85%, rgba(37,99,235,.25), transparent 60%),
        linear-gradient(180deg, #fbfbff 0%, #f7f7fb 55%, #fbfbff 100%);
      filter: blur(22px);
      transform: scale(1.08);
    }

    /* NAVBAR */
    .topnav{
      background: rgba(255,255,255,.9);
      border-bottom:1px solid rgba(229,231,235,.9);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
    }

    .brand{
      display:flex;
      align-items:center;
      gap:10px;
      font-weight:900;
    }

    .brand-badge{
      width:42px;height:42px;
      border-radius:14px;
      background:#111827;
      color:#fff;
      display:flex;
      align-items:center;
      justify-content:center;
    }

    .navlinks a{
      text-decoration:none;
      font-weight:900;
      color:#111827;
      padding:10px 14px;
      border-radius:999px;
      transition:.15s;
      display:inline-block;
    }
    .navlinks a:hover{ background: rgba(17,24,39,.06); }

    /* HERO */
    .hero{ padding:36px 0 20px; }
    .glass{
      background: rgba(255,255,255,.9);
      border:1px solid rgba(229,231,235,.9);
      border-radius:22px;
      box-shadow:0 16px 36px rgba(0,0,0,.08);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
    }
    .hero-inner{ padding:28px; }
    .hero-title{ font-size:34px; font-weight:1000; margin:0; line-height:1.1; }
    .hero-sub{ color:#6b7280; font-weight:700; margin-top:10px; max-width:60ch; }

    .searchbox{
      margin-top:18px;
      background:#fff;
      border-radius:18px;
      padding:12px;
      border:1px solid rgba(229,231,235,.9);
      box-shadow:0 12px 22px rgba(0,0,0,.06);
    }
    .search-input{
      border-radius:14px;
      border:1px solid #e5e7eb;
      padding:12px 14px;
      font-weight:700;
    }

    .quote{
      margin-top:14px;
      padding:14px 16px;
      border-radius:16px;
      background: rgba(17,24,39,.05);
      border: 1px solid rgba(17,24,39,.08);
      font-weight:900;
      display:flex;
      gap:10px;
      align-items:flex-start;
    }
    .quote i{ margin-top:2px; }

    .section-title{
      font-weight:1000;
      font-size:26px;
      margin:28px 0 12px;
    }
    .section-sub{
      color:#6b7280;
      font-weight:700;
      margin-top:-4px;
      margin-bottom:14px;
    }

    /* City in numbers */
    .stat-card{
      background:#fff;
      border:1px solid rgba(229,231,235,.9);
      border-radius:18px;
      padding:18px;
      display:flex;
      gap:14px;
      align-items:center;
      box-shadow:0 14px 26px rgba(0,0,0,.06);
      height:100%;
    }
    .stat-ic{
      width:54px;height:54px;
      border-radius:16px;
      display:flex;
      align-items:center;
      justify-content:center;
      font-size:22px;
      background: rgba(59,130,246,.12);
      border: 1px solid rgba(59,130,246,.18);
    }
    .stat-num{ font-size:28px; font-weight:1000; line-height:1; }
    .stat-lbl{ color:#6b7280; font-weight:800; margin-top:4px; }

    /* Service cards */
    .svc-card{
      position:relative;
      background:#fff;
      border:1px solid rgba(229,231,235,.9);
      border-radius:22px;
      box-shadow:0 16px 32px rgba(0,0,0,.08);
      overflow:hidden;
      transition:.18s;
      height:100%;
    }
    .svc-card:hover{ transform: translateY(-4px); box-shadow:0 22px 42px rgba(0,0,0,.12); }

    .svc-head{
      padding:18px 18px 0;
      display:flex;
      justify-content:space-between;
      align-items:flex-start;
      gap:12px;
    }
    .svc-icon{
      width:52px;height:52px;
      border-radius:18px;
      display:flex;
      align-items:center;
      justify-content:center;
      font-size:22px;
      background:#f3f4f6;
    }
    .svc-body{ padding:14px 18px 18px; }
    .svc-name{ font-size:24px; font-weight:1000; margin:0; }
    .svc-desc{ color:#6b7280; font-weight:700; margin-top:8px; max-width:48ch; }

    .btn-go{
      margin-top:14px;
      display:inline-flex;
      gap:10px;
      align-items:center;
      background:#111827;
      color:#fff;
      border-radius:14px;
      padding:10px 14px;
      text-decoration:none;
      font-weight:1000;
      transition:.15s;
    }
    .btn-go:hover{ filter:brightness(.95); color:#fff; }

    .corner{
      position:absolute;
      right:-70px; top:-70px;
      width:220px;height:220px;
      border-radius:90px;
      opacity:.35;
    }
    .corner-yellow{ background: rgba(245,158,11,.9); }
    .corner-red{ background: rgba(239,68,68,.9); }
    .corner-green{ background: rgba(34,197,94,.9); }
    .corner-blue{ background: rgba(59,130,246,.9); }

    .pill{
      font-size:12px;
      font-weight:1000;
      padding:6px 10px;
      border-radius:999px;
      border:1px solid rgba(0,0,0,.08);
      background: rgba(255,255,255,.75);
    }

    .preview-card{
      background:#fff;
      border:1px solid rgba(229,231,235,.9);
      border-radius:18px;
      box-shadow:0 12px 22px rgba(0,0,0,.06);
      height:100%;
      overflow:hidden;
    }
    .thumb{
      width:100%;
      height:140px;
      object-fit:cover;
      background:#f3f4f6;
    }
    .muted{ color:#6b7280; font-weight:700; }

    .accordion-button{ font-weight:900; }
    .accordion-button:not(.collapsed){ background: rgba(59,130,246,.10); }

    .footer{
      padding:30px 0 34px;
      color:#6b7280;
      font-weight:700;
      text-align:center;
    }
  </style>
</head>

<body>
<div class="blur-bg"></div>


<nav class="navbar topnav">
  <div class="container py-2">

    <div class="brand">
      <div class="brand-badge">SC</div>
      <div>
        <div style="line-height:1">SmartCity</div>
        <small class="text-muted fw-bold">Public Services</small>
      </div>
    </div>

    <div class="ms-auto d-flex flex-wrap align-items-center gap-1 navlinks">
      <a href="#services">Services</a>
      <a href="#about">About Us</a>
      <a href="#faq">Q&amp;As</a>
      <a href="<%= ctx %>/MapServlet">City Map</a>
    </div>

  
    <div class="ms-3 d-flex align-items-center gap-2">
      <% if (loggedUser == null) { %>
        <a class="btn btn-outline-dark fw-bold" href="<%= ctx %>/login.jsp">
          <i class="fa-solid fa-right-to-bracket me-2"></i>Login
        </a>
        <a class="btn btn-dark fw-bold" href="<%= ctx %>/register.jsp">
          <i class="fa-solid fa-user-plus me-2"></i>Register
        </a>
      <% } else { %>
        <span class="fw-bold text-muted">Welcome, <%= loggedUser.getUsername() %></span>
        <a class="btn btn-danger fw-bold" href="<%= ctx %>/LogoutServlet">
          <i class="fa-solid fa-right-from-bracket me-2"></i>Logout
        </a>
      <% } %>

      <!-- ADMIN -->
      <a class="btn btn-outline-primary fw-bold" href="<%= ctx %>/login.jsp">
        <i class="fa-solid fa-user-shield me-2"></i>Admin
      </a>
    </div>

  </div>
</nav>

<div class="container hero">

  <!-- HERO -->
  <div class="glass">
    <div class="hero-inner">
      <h1 class="hero-title">Discover your city services</h1>
      <div class="hero-sub">
        Tourism places, job opportunities, businesses, and educational places — managed by the city administration and shown here for everyone.
      </div>

      <div class="searchbox">
        <div class="input-group">
          <span class="input-group-text bg-white" style="border:1px solid #e5e7eb; border-radius:14px 0 0 14px;">
            <i class="fa-solid fa-magnifying-glass"></i>
          </span>
          <input id="globalSearch" class="form-control search-input"
                 placeholder="Search services… (tourism / jobs / business / education)"
                 style="border-radius:0 14px 14px 0;">
        </div>
      </div>

      <div class="quote">
        <i class="fa-solid fa-seedling"></i>
        <div>
          “A clean city is a shared responsibility.”<br>
          <span class="muted">Respect public spaces, support local work, and protect our environment.</span>
        </div>
      </div>

      <!-- CITY IN NUMBERS -->
      <div class="section-title" style="margin-top:22px;">City in Numbers</div>
      <div class="row g-3">
        <div class="col-12 col-md-6 col-lg-3">
          <div class="stat-card">
            <div class="stat-ic"><i class="fa-solid fa-school"></i></div>
            <div>
              <div class="stat-num"><%= studentsCount %></div>
              <div class="stat-lbl">Educational Places</div>
            </div>
          </div>
        </div>

        <div class="col-12 col-md-6 col-lg-3">
          <div class="stat-card">
            <div class="stat-ic"><i class="fa-solid fa-umbrella-beach"></i></div>
            <div>
              <div class="stat-num"><%= tourismCount %></div>
              <div class="stat-lbl">Tourism places</div>
            </div>
          </div>
        </div>

        <div class="col-12 col-md-6 col-lg-3">
          <div class="stat-card">
            <div class="stat-ic"><i class="fa-solid fa-briefcase"></i></div>
            <div>
              <div class="stat-num"><%= jobsCount %></div>
              <div class="stat-lbl">Job posts</div>
            </div>
          </div>
        </div>

        <div class="col-12 col-md-6 col-lg-3">
          <div class="stat-card">
            <div class="stat-ic"><i class="fa-solid fa-building"></i></div>
            <div>
              <div class="stat-num"><%= businessCount %></div>
              <div class="stat-lbl">Businesses</div>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>

  <!-- SERVICES -->
  <div class="section-title" id="services">Services</div>
  <div class="section-sub">Choose a service category to explore what the admin added to the database.</div>

  <div class="row g-3" id="serviceCards">

    <!-- TOURISM -->
    <div class="col-12 col-md-6 col-lg-4 svc">
      <div class="svc-card">
        <div class="corner corner-yellow"></div>
        <div class="svc-head">
          <div class="svc-icon"><i class="fa-solid fa-umbrella-beach"></i></div>
          <span class="pill">Tourism</span>
        </div>
        <div class="svc-body">
          <h3 class="svc-name">Tourism Places</h3>
          <div class="svc-desc">Explore attractions added by the admin.</div>
          <a class="btn-go" href="<%= ctx %>/PublicTourismServlet">Explore Tourism <i class="fa-solid fa-arrow-right"></i></a>
        </div>
      </div>
    </div>

    <!-- JOBS -->
    <div class="col-12 col-md-6 col-lg-4 svc">
      <div class="svc-card">
        <div class="corner corner-red"></div>
        <div class="svc-head">
          <div class="svc-icon"><i class="fa-solid fa-briefcase"></i></div>
          <span class="pill">Jobs</span>
        </div>
        <div class="svc-body">
          <h3 class="svc-name">Job Opportunities</h3>
          <div class="svc-desc">Find jobs and internships verified by admin.</div>
          <a class="btn-go" href="<%= ctx %>/PublicJobServlet">View Jobs <i class="fa-solid fa-arrow-right"></i></a>
        </div>
      </div>
    </div>

    <!-- BUSINESS -->
    <div class="col-12 col-md-6 col-lg-4 svc">
      <div class="svc-card">
        <div class="corner corner-green"></div>
        <div class="svc-head">
          <div class="svc-icon"><i class="fa-solid fa-building"></i></div>
          <span class="pill">Business</span>
        </div>
        <div class="svc-body">
          <h3 class="svc-name">Local Businesses</h3>
          <div class="svc-desc">Discover cafés, services, shops.</div>
          <a class="btn-go" href="<%= ctx %>/PublicBusinessServlet">Browse Business <i class="fa-solid fa-arrow-right"></i></a>
        </div>
      </div>
    </div>

    <!-- EDUCATION -->
    <div class="col-12 col-md-6 col-lg-4 svc">
      <div class="svc-card">
        <div class="corner corner-blue"></div>
        <div class="svc-head">
          <div class="svc-icon"><i class="fa-solid fa-school"></i></div>
          <span class="pill">Education</span>
        </div>
        <div class="svc-body">
          <h3 class="svc-name">Educational Places</h3>
          <div class="svc-desc">Universities, schools, institutes, and learning centers.</div>
          <a class="btn-go" href="<%= ctx %>/PublicEducationServlet">Explore Education <i class="fa-solid fa-arrow-right"></i></a>
        </div>
      </div>
    </div>

  </div>

  <!-- LATEST -->
  <div class="section-title">Latest Added</div>
  <div class="section-sub">Quick preview of the latest items</div>

  <!-- Tourism preview -->
  <div class="glass p-3 mb-3">
    <div class="d-flex justify-content-between align-items-center mb-2">
      <div style="font-weight:1000;"><i class="fa-solid fa-umbrella-beach me-2"></i>Tourism (Latest)</div>
      <a class="fw-bold" href="<%= ctx %>/PublicTourismServlet" style="text-decoration:none;">View all <i class="fa-solid fa-arrow-right ms-1"></i></a>
    </div>
    <div class="row g-3">
      <% for (Tourism t : tourismList) { 
           String img = t.getImageUrl();
           boolean hasImg = (img != null && !img.trim().isEmpty());
      %>
      <div class="col-12 col-md-6 col-lg-3 svc">
        <div class="preview-card">
          <% if (hasImg) { %>
            <img class="thumb" src="<%= img %>" alt="tourism">
          <% } else { %>
            <div class="thumb d-flex align-items-center justify-content-center muted">NO IMAGE</div>
          <% } %>
          <div class="p-3">
            <div style="font-weight:1000;"><%= t.getName() %></div>
            <div class="muted"><i class="fa-solid fa-location-dot me-1"></i><%= t.getLocation() %></div>
          </div>
        </div>
      </div>
      <% } %>
      <% if (tourismList.isEmpty()) { %>
      <div class="col-12 text-center muted fw-bold py-4">No tourism places yet.</div>
      <% } %>
    </div>
  </div>

  <!-- Jobs preview -->
  <div class="glass p-3 mb-3">
    <div class="d-flex justify-content-between align-items-center mb-2">
      <div style="font-weight:1000;"><i class="fa-solid fa-briefcase me-2"></i>Jobs (Latest)</div>
      <a class="fw-bold" href="<%= ctx %>/PublicJobServlet" style="text-decoration:none;">View all <i class="fa-solid fa-arrow-right ms-1"></i></a>
    </div>
    <div class="row g-3">
      <% for (Job j : jobList) { %>
      <div class="col-12 col-md-6 col-lg-3 svc">
        <div class="preview-card p-3">
          <div style="font-weight:1000;"><%= j.getTitle() %></div>
          <div class="muted"><%= j.getCompany() %></div>
          <div class="muted"><i class="fa-solid fa-location-dot me-1"></i><%= j.getLocation() %></div>
          <div class="muted"><i class="fa-solid fa-tag me-1"></i><%= j.getJobType() %></div>
        </div>
      </div>
      <% } %>
      <% if (jobList.isEmpty()) { %>
      <div class="col-12 text-center muted fw-bold py-4">No jobs posted yet.</div>
      <% } %>
    </div>
  </div>

  <!-- Business preview -->
  <div class="glass p-3 mb-3">
    <div class="d-flex justify-content-between align-items-center mb-2">
      <div style="font-weight:1000;"><i class="fa-solid fa-building me-2"></i>Business (Latest)</div>
      <a class="fw-bold" href="<%= ctx %>/PublicBusinessServlet" style="text-decoration:none;">View all <i class="fa-solid fa-arrow-right ms-1"></i></a>
    </div>
    <div class="row g-3">
      <% for (Business b : businessList) { %>
      <div class="col-12 col-md-6 col-lg-3 svc">
        <div class="preview-card p-3">
          <div style="font-weight:1000;"><%= b.getName() %></div>
          <div class="muted"><i class="fa-solid fa-layer-group me-1"></i><%= b.getCategory() %></div>
          <div class="muted"><i class="fa-solid fa-location-dot me-1"></i><%= b.getLocation() %></div>
        </div>
      </div>
      <% } %>
      <% if (businessList.isEmpty()) { %>
      <div class="col-12 text-center muted fw-bold py-4">No businesses yet.</div>
      <% } %>
    </div>
  </div>

  <!-- Education preview -->
  <div class="glass p-3 mb-4">
    <div class="d-flex justify-content-between align-items-center mb-2">
      <div style="font-weight:1000;"><i class="fa-solid fa-school me-2"></i>Educational Places (Latest)</div>
      <a class="fw-bold" href="<%= ctx %>/PublicEducationServlet" style="text-decoration:none;">View all <i class="fa-solid fa-arrow-right ms-1"></i></a>
    </div>

    <div class="row g-3">
      <% for (Student s : eduList) {
           String img = s.getImageUrl();
           boolean hasImg = (img != null && !img.trim().isEmpty());
      %>
      <div class="col-12 col-md-6 col-lg-3 svc">
        <div class="preview-card">
          <% if (hasImg) { %>
            <img class="thumb" src="<%= img %>" alt="education">
          <% } else { %>
            <div class="thumb d-flex align-items-center justify-content-center muted">NO IMAGE</div>
          <% } %>
          <div class="p-3">
            <div style="font-weight:1000;"><%= s.getFullName() %></div>
            <div class="muted"><i class="fa-solid fa-location-dot me-1"></i><%= s.getUniversity() %></div>
            <div class="muted"><i class="fa-solid fa-layer-group me-1"></i><%= s.getMajor() %></div>
          </div>
        </div>
      </div>
      <% } %>
      <% if (eduList.isEmpty()) { %>
        <div class="col-12 text-center muted fw-bold py-4">No educational places yet.</div>
      <% } %>
    </div>
  </div>

 <div class="section-title" id="about">About Us</div> 
   <div class="glass p-4">     
 <div class="row g-4 align-items-center">    
    <div class="col-12 col-lg-7">      
       <h3 style="font-weight:1000; margin:0 0 10px 0;">SmartCity Public Services</h3>     
           <div class="muted">           SmartCity helps residents and visitors access trusted public information in one place.     
                 Tourism, jobs, and business listings are managed by the administration to keep everything accurate.         </div>   
                  <div class="quote mt-3">       
                      <i class="fa-solid fa-heart"></i>     
                            <div>             “Together we keep our city safe, clean, and welcoming.”<br>           
                              <span class="muted">Small actions make a big difference.</span>      
                                   </div>   
                                         </div>    
                                            </div>   
                                                 <div class="col-12 col-lg-5">      
                                                    <div class="preview-card p-4">  
                                                             <div class="d-flex gap-3">    
                                                                      <div class="stat-ic"><i class="fa-solid fa-shield-heart"></i></div>        
                       <div>          
                            <div style="font-weight:1000; font-size:18px;">Verified Listings</div>        
                                   <div class="muted">Only admins can add/edit services, so public pages stay reliable.</div>       
                                         </div>      
                                              </div>       
                                                  <hr style="opacity:.15;">       
                                                      <div class="d-flex gap-3">    
                                                               <div class="stat-ic"><i class="fa-solid fa-bolt"></i></div>         
                                                                   <div>               <div style="font-weight:1000; font-size:18px;">Fast Search</div> 
                                                                                 <div class="muted">Use the search bar to quickly filter services and find what you need.</div>             </div>           </div>         </div>       </div>      </div>   </div>    <!-- FAQ -->   <div class="section-title" id="faq">Q&amp;As</div>   <div class="glass p-3 mb-2">     <div class="accordion" id="faqAcc">        <div class="accordion-item" style="border-radius:14px; overflow:hidden; border:1px solid rgba(229,231,235,.9);">         <h2 class="accordion-header">           <button class="accordion-button fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#q1">             Who can add or edit services?           </button>         </h2>         <div id="q1" class="accordion-collapse collapse show" data-bs-parent="#faqAcc">           <div class="accordion-body muted fw-bold">             Only admin users can manage Tourism/Jobs/Business/Students data. Public visitors can only view.           </div>         </div>       </div>        <div class="accordion-item mt-2" style="border-radius:14px; overflow:hidden; border:1px solid rgba(229,231,235,.9);">         <h2 class="accordion-header">           <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#q2">             Why do some tourism items show no image?           </button>         </h2>         <div id="q2" class="accordion-collapse collapse" data-bs-parent="#faqAcc">           <div class="accordion-body muted fw-bold">             An image appears only if the admin saved a valid image URL (or uploaded + stored the URL in DB).           </div>         </div>       </div>        <div class="accordion-item mt-2" style="border-radius:14px; overflow:hidden; border:1px solid rgba(229,231,235,.9);">         <h2 class="accordion-header">           <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#q3">             How does the search work?           </button>         </h2>         <div id="q3" class="accordion-collapse collapse" data-bs-parent="#faqAcc">           <div class="accordion-body muted fw-bold">             The search filters cards on this page instantly (client-side). Type any keyword like a place name, “internship”, or “café”.           </div>         </div>       </div>      </div>   </div>    <div class="footer">     © SmartCity — Public Services Portal   </div> </div>  <script>   // Global filter (client-side)   const s = document.getElementById("globalSearch");   s.addEventListener("keyup", function(){     const q = this.value.toLowerCase();     document.querySelectorAll(".svc").forEach(card=>{       card.style.display = card.innerText.toLowerCase().includes(q) ? "" : "none";     });   }); </script>  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> </body> </html>