package hospital.group.codes;

public class roomJava{
    private String roomId;
    private String roomNumber;
    private String roomType;
    private String availabilityStatus;
    private String assignedPatientId;
    private int floorNumber;
    private String departmentId;
    private String lastCleanedAt;
    private double dailyRate;

    public roomJava(String roomId, String roomNumber, String roomType, String availabilityStatus,
                String assignedPatientId, int floorNumber, String departmentId,
                String lastCleanedAt, double dailyRate) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.availabilityStatus = availabilityStatus;
        this.assignedPatientId = assignedPatientId;
        this.floorNumber = floorNumber;
        this.departmentId = departmentId;
        this.lastCleanedAt = lastCleanedAt;
        this.dailyRate = dailyRate;
    }

    // Getter methods
    public String getRoomId() { return roomId; }
    public String getRoomNumber() { return roomNumber; }
    public String getRoomType() { return roomType; }
    public String getAvailabilityStatus() { return availabilityStatus; }
    public String getAssignedPatientId() { return assignedPatientId; }
    public int getFloorNumber() { return floorNumber; }
    public String getDepartmentId() { return departmentId; }
    public String getLastCleanedAt() { return lastCleanedAt; }
    public double getDailyRate() { return dailyRate; }
}
