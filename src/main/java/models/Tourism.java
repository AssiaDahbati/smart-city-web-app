package models;

public class Tourism {
    private int id;                
    private String name;
    private String location;
    private String description;
    private String imageUrl;

    // Full constructor (used when reading from database)
    public Tourism(int id, String name, String location,
                   String description, String imageUrl) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.description = description;
        this.imageUrl = imageUrl;
    }

    // Constructor for inserting new tourism places (ID auto-generated)
    public Tourism(String name, String location,
                   String description, String imageUrl) {
        this.name = name;
        this.location = location;
        this.description = description;
        this.imageUrl = imageUrl;
    }

    // GETTERS & SETTERS
    public int getId() { 
        return id; 
    }

    public void setId(int id) { 
        this.id = id; 
    }

    public String getName() { 
        return name; 
    }

    public void setName(String name) { 
        this.name = name; 
    }

    public String getLocation() { 
        return location; 
    }

    public void setLocation(String location) { 
        this.location = location; 
    }

    public String getDescription() { 
        return description; 
    }

    public void setDescription(String description) { 
        this.description = description; 
    }

    public String getImageUrl() { 
        return imageUrl; 
    }

    public void setImageUrl(String imageUrl) { 
        this.imageUrl = imageUrl; 
    }

	public void setLatitude(Double lat) {
		// TODO Auto-generated method stub
		
	}

	public Object getLatitude() {
		// TODO Auto-generated method stub
		return null;
	}

	public Object getLongitude() {
		// TODO Auto-generated method stub
		return null;
	}

	public void setLongitude(Double lng) {
		// TODO Auto-generated method stub
		
	}
}
