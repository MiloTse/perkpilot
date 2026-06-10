-- ============================================================
-- V2: 权益表 benefit（必须挂在某个 tenant 下）
-- ============================================================

CREATE TABLE benefit (
                         id              BIGSERIAL PRIMARY KEY,
                         tenant_id       BIGINT       NOT NULL,
                         code            VARCHAR(64)  NOT NULL,
                         name            VARCHAR(255) NOT NULL,
                         description     TEXT,
                         status          VARCHAR(32)  NOT NULL DEFAULT 'ACTIVE',
                         valid_from      TIMESTAMPTZ,
                         valid_to        TIMESTAMPTZ,
                         created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
                         updated_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
                         CONSTRAINT fk_benefit_tenant
                             FOREIGN KEY (tenant_id) REFERENCES tenant (id),
                         CONSTRAINT uk_benefit_tenant_code UNIQUE (tenant_id, code)
);

CREATE INDEX idx_benefit_tenant_id ON benefit (tenant_id);
CREATE INDEX idx_benefit_tenant_status ON benefit (tenant_id, status);

COMMENT ON TABLE benefit IS 'Benefit catalog scoped by tenant_id';