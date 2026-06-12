package com.perkpilot.api.tenant;

import com.perkpilot.api.tenant.dto.TenantCreateRequest;
import com.perkpilot.api.tenant.dto.TenantResponse;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class TenantService {

    private final TenantMapper tenantMapper;

    public TenantService(TenantMapper tenantMapper) {
        this.tenantMapper = tenantMapper;
    }

    public TenantResponse create(TenantCreateRequest request) {
        Tenant tenant = new Tenant();
        tenant.setCode(request.getCode());
        tenant.setName(request.getName());
        tenant.setStatus(TenantStatus.ACTIVE);
        tenantMapper.insert(tenant);
        return toResponse(tenant);
    }

    public TenantResponse getById(Long id) {
        Tenant tenant = tenantMapper.findById(id)
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Tenant not found: " + id));
        return toResponse(tenant);
    }

    public List<TenantResponse> listAll() {
        return tenantMapper.findAll().stream()
                .map(this::toResponse)
                .toList();
    }

    private TenantResponse toResponse(Tenant tenant) {
        TenantResponse response = new TenantResponse();
        response.setId(tenant.getId());
        response.setCode(tenant.getCode());
        response.setName(tenant.getName());
        response.setStatus(tenant.getStatus());
        response.setCreatedAt(tenant.getCreatedAt());
        response.setUpdatedAt(tenant.getUpdatedAt());
        return response;
    }
}