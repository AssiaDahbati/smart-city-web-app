package models;

public class CityPlace {

    private int id;

    
    private String sourceType;  
    private int sourceId;        

    private String name;
    private String category;
    private String address;
    private String description;

    private Double lat;
    private Double lng;

    private String imageUrl;

   
    public CityPlace(int id, String sourceType, int sourceId,
                     String name, String category, String address,
                     String description, Double lat, Double lng, String imageUrl) {
        this.id = id;
        this.sourceType = sourceType;
        this.sourceId = sourceId;
        this.name = name;
        this.category = category;
        this.address = address;
        this.description = description;
        this.lat = lat;
        this.lng = lng;
        this.imageUrl = imageUrl;
    }

    
    public CityPlace(int id, String name, String category, String address,
                     String description, Double lat, Double lng) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.address = address;
        this.description = description;
        this.lat = lat;
        this.lng = lng;
    }

    public CityPlace(int id, String name, String category, String address,
                     Double lat, Double lng) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.address = address;
        this.lat = lat;
        this.lng = lng;
    }


    public int getId() { return id; }

    public String getSourceType() { return sourceType; }
    public int getSourceId() { return sourceId; }

    public String getName() { return name; }
    public String getCategory() { return category; }
    public String getAddress() { return address; }
    public String getDescription() { return description; }

    
    public Double getLat() { return lat; }
    public Double getLng() { return lng; }


    public Double getLatitude() { return lat; }
    public Double getLongitude() { return lng; }

    public String getImageUrl() { return imageUrl; }

  
    public void setId(int id) { this.id = id; }

    public void setSourceType(String sourceType) { this.sourceType = sourceType; }
    public void setSourceId(int sourceId) { this.sourceId = sourceId; }

    public void setName(String name) { this.name = name; }
    public void setCategory(String category) { this.category = category; }
    public void setAddress(String address) { this.address = address; }
    public void setDescription(String description) { this.description = description; }

    public void setLat(Double lat) { this.lat = lat; }
    public void setLng(Double lng) { this.lng = lng; }

    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}
