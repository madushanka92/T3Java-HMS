package hospital.group.model;

import java.security.Timestamp;

public class FeatureMapping {
	private int mappingId;
    private int featureId;
    private int roleId;
    private boolean canCreate;
    private boolean canRead;
    private boolean canUpdate;
    private boolean canDelete;
    private Timestamp createdAt;
    private Timestamp updatedAt;
	public FeatureMapping(int mappingId, int featureId, int roleId, boolean canCreate, boolean canRead,
			boolean canUpdate, boolean canDelete, Timestamp createdAt, Timestamp updatedAt) {
		super();
		this.mappingId = mappingId;
		this.featureId = featureId;
		this.roleId = roleId;
		this.canCreate = canCreate;
		this.canRead = canRead;
		this.canUpdate = canUpdate;
		this.canDelete = canDelete;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
	public int getMappingId() {
		return mappingId;
	}
	public void setMappingId(int mappingId) {
		this.mappingId = mappingId;
	}
	public int getFeatureId() {
		return featureId;
	}
	public void setFeatureId(int featureId) {
		this.featureId = featureId;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public boolean isCanCreate() {
		return canCreate;
	}
	public void setCanCreate(boolean canCreate) {
		this.canCreate = canCreate;
	}
	public boolean isCanRead() {
		return canRead;
	}
	public void setCanRead(boolean canRead) {
		this.canRead = canRead;
	}
	public boolean isCanUpdate() {
		return canUpdate;
	}
	public void setCanUpdate(boolean canUpdate) {
		this.canUpdate = canUpdate;
	}
	public boolean isCanDelete() {
		return canDelete;
	}
	public void setCanDelete(boolean canDelete) {
		this.canDelete = canDelete;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}


}
