package com.perkpilot.api.tenant;

import com.perkpilot.api.tenant.dto.TenantCreateRequest;
import com.perkpilot.api.tenant.dto.TenantResponse;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/tenants")
public class TenantController {

    private final TenantService tenantService;

    public TenantController(TenantService tenantService) {
        this.tenantService = tenantService;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public TenantResponse create(@RequestBody TenantCreateRequest request) {
        return tenantService.create(request);
    }

    @GetMapping
    public List<TenantResponse> list() {
        return tenantService.listAll();
    }

    @GetMapping("/{id}")
    public TenantResponse get(@PathVariable Long id) {
        return tenantService.getById(id);
    }
}