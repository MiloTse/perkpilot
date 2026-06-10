-- ============================================================
-- V1: 租户表 tenant
-- 一个租户 = 一家金融机构（如 TD、BMO 演示数据）
-- ============================================================

CREATE TABLE tenant (
                        id              BIGSERIAL PRIMARY KEY,
                        code            VARCHAR(64)  NOT NULL,
                        name            VARCHAR(255) NOT NULL,
                        status          VARCHAR(32)  NOT NULL DEFAULT 'ACTIVE',
                        created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
                        updated_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
                        CONSTRAINT uk_tenant_code UNIQUE (code)
);

CREATE INDEX idx_tenant_status ON tenant (status);

COMMENT ON TABLE tenant IS 'Multi-tenant root: financial institution';
COMMENT ON COLUMN tenant.code IS 'Unique business code, e.g. TD, BMO';