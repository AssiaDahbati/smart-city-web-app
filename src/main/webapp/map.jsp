<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="models.CityPlace" %>

<%
  String ctx = request.getContextPath();
  List<CityPlace> places = (List<CityPlace>) request.getAttribute("places");
  if (places == null) places = new ArrayList<>();

  String q = (String) request.getAttribute("q");
  if (q == null) q = "";
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>SmartCity - City Map</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

 
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
  <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

  <style>
    body{ background:#f7f7fb; font-family:system-ui,Arial; }
    .topbar{
      background:#fff;
      border-bottom:1px solid #e5e7eb;
      padding:14px 18px;
      display:flex;
      align-items:center;
      justify-content:space-between;
    }
    .wrap{ padding:18px; }
    #map{ height: 560px; border-radius:18px; border:1px solid #e5e7eb; }
    .glass{
      .blur-bg{
      position:fixed;
      inset:0;
      z-index:-1;
      background:
        radial-gradient(circle at 15% 20%, rgba(59,130,246,.35), transparent 55%),
        radial-gradient(circle at 80% 10%, rgba(37,99,235,.28), transparent 55%),
        radial-gradient(circle at 50% 90%, rgba(99,102,241,.20), transparent 55%),
        linear-gradient(180deg, #f7fbff 0%, #f6f7fb 50%, #f7fbff 100%);
      filter: blur(18px);
      transform: scale(1.08); }
    }
      border:1px solid #e5e7eb;
      border-radius:18px;
      box-shadow:0 14px 26px rgba(0,0,0,.06);
    }
    .place-item{
      padding:12px 14px;
      border-bottom:1px solid #eef2f7;
      cursor:pointer;
    }
    .place-item:hover{ background:#f3f4f6; }
    .pill{
      font-size:12px;
      font-weight:900;
      padding:4px 10px;
      border-radius:999px;
      background:#dbeafe;
      color:#1e40af;
      display:inline-block;
    }
  </style>
</head>

<body>

<div class="topbar">
  <div class="fw-bold"><i class="fa-solid fa-map-location-dot me-2"></i>City Map</div>
  <a class="btn btn-dark btn-sm" href="<%= ctx %>/HomeServlet"><i class="fa-solid fa-house me-2"></i>Home</a>
</div>

<div class="wrap container-fluid">
  <div class="row g-3">
    <div class="col-12 col-lg-4">
      <div class="glass p-3">
        <form method="get" action="<%= ctx %>/MapServlet">
          <label class="fw-bold mb-2">Search places (from DB)</label>
          <div class="input-group">
            <input class="form-control" name="q" value="<%= q %>" placeholder="library, university, museum...">
            <button class="btn btn-primary fw-bold" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
          </div>
          <small class="text-muted fw-bold">Tip: click any result to zoom on the map.</small>
        </form>

        <hr>

        <div style="max-height:420px; overflow:auto;">
          <% if(places.isEmpty()) { %>
            <div class="text-muted fw-bold p-3">No places found.</div>
          <% } %>

          <% for(CityPlace p : places){ %>
            <div class="place-item"
                onclick="focusPlace(<%= p.getLatitude() %>, <%= p.getLongitude() %>, '...')">
                
              <div class="d-flex justify-content-between align-items-center">
                <div class="fw-bold"><%= p.getName() %></div>
                <span class="pill"><%= p.getCategory() %></span>
              </div>
              <div class="text-muted small fw-bold">
                <i class="fa-solid fa-location-dot me-1"></i><%= p.getAddress() %>
              </div>
            </div>
          <% } %>
        </div>

      </div>
    </div>

    <div class="col-12 col-lg-8">
      <div id="map"></div>
    </div>
  </div>
</div>

<script>
  // Default center (change to your city)
  const map = L.map('map').setView([35.7806, -5.8137], 12);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap'
  }).addTo(map);

  const markers = [];

  <% for(CityPlace p : places){ %>
    (function(){
      const m = L.marker([<%= p.getLat() %>, <%= p.getLng() %>]).addTo(map);
      m.bindPopup("<b><%= p.getName().replace("\"","\\\"") %></b><br><%= (p.getAddress()==null?"":p.getAddress().replace("\"","\\\"")) %>");
      markers.push(m);
    })();
  <% } %>

  function focusPlace(lat, lng, name){
    map.setView([lat, lng], 15, {animate:true});
    // find nearest marker and open popup
    markers.forEach(m=>{
      const ll = m.getLatLng();
      if (Math.abs(ll.lat - lat) < 0.00001 && Math.abs(ll.lng - lng) < 0.00001) {
        m.openPopup();
      }
    });
  }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
