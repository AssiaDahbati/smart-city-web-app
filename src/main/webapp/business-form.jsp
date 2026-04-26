<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Business" %>

<%
  Business b = (Business) request.getAttribute("business");
  boolean editing = (b != null);

  String name = editing ? b.getName() : "";
  String category = editing ? b.getCategory() : "";
  String location = editing ? b.getLocation() : "";
  String description = editing ? b.getDescription() : "";
  String contactEmail = editing ? b.getContactEmail() : "";


  boolean isOther = (category != null && !category.isEmpty() &&
          !(category.equals("Café") ||
            category.equals("Restaurant") ||
            category.equals("Hotel / Riad") ||
            category.equals("Shopping Mall") ||
            category.equals("Technology") ||
            category.equals("Transport / Port") ||
            category.equals("Utility Company") ||
            category.equals("Industrial / Business Zone")));
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><%= editing ? "Edit Business" : "Add Business" %></title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
    body{
      font-family:system-ui,Arial;
      background:
        radial-gradient(circle at 10% 10%, rgba(34,197,94,.18), transparent 45%),
        radial-gradient(circle at 90% 20%, rgba(59,130,246,.10), transparent 45%),
        radial-gradient(circle at 20% 90%, rgba(245,158,11,.10), transparent 45%),
        #f6f7fb;
      min-height:100vh;
    }

    .wrap{
      max-width: 980px;
      margin: 28px auto;
      padding: 0 14px;
    }

    .cardx{
      background: rgba(255,255,255,.75);
      border: 1px solid rgba(229,231,235,.9);
      border-radius: 20px;
      box-shadow: 0 18px 40px rgba(0,0,0,.08);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      overflow:hidden;
    }

    .cardx-header{
      padding: 18px 20px;
      border-bottom: 1px solid rgba(229,231,235,.9);
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap: 12px;
    }

    .title{
      margin:0;
      font-size: 22px;
      font-weight: 900;
      color:#111827;
      display:flex;
      align-items:center;
      gap:10px;
    }

    .badge-green{
      font-size: 12px;
      font-weight: 900;
      padding: 6px 10px;
      border-radius: 999px;
      background: #22c55e; /* grass green */
      color:#fff;
      letter-spacing: .4px;
    }

    .form-control, .form-select{
      border-radius: 12px;
      border: 1px solid #e5e7eb;
      padding: 10px 12px;
      background: rgba(255,255,255,.9);
    }

    .btn-soft{
      border:0;
      border-radius: 12px;
      padding: 10px 14px;
      font-weight: 900;
    }

    .btn-business{
      background:#22c55e; /* grass green */
      color:#0b1220;
    }

    .btn-darkx{
      background:#111827;
      color:#fff;
    }

    .hint{
      color:#6b7280;
      font-size: 13px;
      margin-top: 6px;
    }
  </style>
</head>

<body>

<div class="wrap">
  <div class="cardx">

    <div class="cardx-header">
      <div class="d-flex align-items-center gap-2">
        <h2 class="title">
          <i class="fa-solid fa-building"></i>
          <%= editing ? "Edit Business" : "Add Business" %>
        </h2>
        <span class="badge-green">BUSINESS</span>
      </div>

      <a href="BusinessServlet" class="btn btn-soft btn-darkx">
        <i class="fa-solid fa-arrow-left me-2"></i>Back
      </a>
    </div>

    <div class="p-4">
      <!-- IMPORTANT: action should match your servlet mapping -->
      <form action="BusinessServlet" method="post">
        <input type="hidden" name="id" value="<%= editing ? b.getId() : "" %>">

        <div class="row g-3">

          <!-- Name -->
          <div class="col-12 col-md-6">
            <label class="form-label fw-bold">Business Name</label>
            <input type="text" name="name" class="form-control" required value="<%= name %>">
          </div>

        
          <div class="col-12 col-md-6">
            <label class="form-label fw-bold">Category</label>

            <select class="form-select" id="categorySelect">
              <option value="">Select category</option>
              <option value="Café" <%= "Café".equals(category) ? "selected" : "" %>>Café</option>
              <option value="Restaurant" <%= "Restaurant".equals(category) ? "selected" : "" %>>Restaurant</option>
              <option value="Hotel / Riad" <%= "Hotel / Riad".equals(category) ? "selected" : "" %>>Hotel / Riad</option>
              <option value="Shopping Mall" <%= "Shopping Mall".equals(category) ? "selected" : "" %>>Shopping Mall</option>
              <option value="Technology" <%= "Technology".equals(category) ? "selected" : "" %>>Technology</option>
              <option value="Transport / Port" <%= "Transport / Port".equals(category) ? "selected" : "" %>>Transport / Port</option>
              <option value="Utility Company" <%= "Utility Company".equals(category) ? "selected" : "" %>>Utility Company</option>
              <option value="Industrial / Business Zone" <%= "Industrial / Business Zone".equals(category) ? "selected" : "" %>>Industrial / Business Zone</option>
              <option value="Other" <%= isOther ? "selected" : "" %>>Other</option>
            </select>

           
            <input type="hidden" name="category" id="finalCategory" value="<%= category %>">

            
            <input type="text"
                   id="otherCategory"
                   class="form-control mt-2"
                   placeholder="Write custom category"
                   style="display:<%= isOther ? "block" : "none" %>;"
                   value="<%= isOther ? category : "" %>">

            <div class="hint">If you choose <b>Other</b>, write your category.</div>
          </div>

          <!-- Location -->
          <div class="col-12 col-md-6">
            <label class="form-label fw-bold">Location</label>
            <input type="text" name="location" class="form-control" value="<%= location %>">
          </div>

          <!-- Contact Email -->
          <div class="col-12 col-md-6">
            <label class="form-label fw-bold">Contact Email</label>
            <input type="email" name="contactEmail" class="form-control" value="<%= contactEmail %>">
          </div>

          <!-- Description -->
          <div class="col-12">
            <label class="form-label fw-bold">Description</label>
            <textarea name="description" class="form-control" rows="4"><%= description %></textarea>
          </div>

          <!-- Buttons -->
          <div class="col-12 d-flex gap-2 mt-2">
            <button type="submit" class="btn btn-soft btn-business">
              <i class="fa-solid fa-floppy-disk me-2"></i>
              <%= editing ? "Update" : "Save" %>
            </button>

            <a href="BusinessServlet" class="btn btn-soft btn-darkx">
              Cancel
            </a>
          </div>

        </div>
      </form>
    </div>

  </div>
</div>

<script>
  const select = document.getElementById("categorySelect");
  const otherInput = document.getElementById("otherCategory");
  const hidden = document.getElementById("finalCategory");

  function updateCategory() {
    if (select.value === "Other") {
      otherInput.style.display = "block";
      hidden.value = otherInput.value;
      otherInput.required = true;
    } else {
      otherInput.style.display = "none";
      otherInput.required = false;
      hidden.value = select.value;
    }
  }

  select.addEventListener("change", updateCategory);
  otherInput.addEventListener("input", () => {
    hidden.value = otherInput.value;
  });

  // init on load
  updateCategory();
</script>

</body>
</html>
