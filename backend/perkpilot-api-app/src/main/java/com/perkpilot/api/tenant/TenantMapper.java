package com.perkpilot.api.tenant;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface TenantMapper {

    int insert(Tenant tenant);

    Optional<Tenant> findById(@Param("id") Long id);

    List<Tenant> findAll();

    int update(Tenant tenant);
}