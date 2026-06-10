-- =============================================================================
-- 开发阶段手测sql
-- IDEA DATASOURCE connect config：
-- Driver: PostgreSQL/Host:localhost/Port:5433/Database:perkpilot/User:perkpilot（same as docker-compose.yml）
-- =============================================================================

-- --- [1] Flyway 迁移历史（只读）---
SELECT installed_rank, version, description, success
FROM flyway_schema_history
ORDER BY installed_rank;

-- --- [2] tenant 表结构（只读）---
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'tenant'
ORDER BY ordinal_position;

-- --- [3] benefit 表结构（只读）---
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'benefit'
ORDER BY ordinal_position;

-- --- [4] 当前数据一览（只读；有数据后再跑）---
-- SELECT id, code, name, status, created_at FROM tenant ORDER BY id;
-- SELECT id, tenant_id, code, name, status FROM benefit ORDER BY tenant_id, id;

-- --- [5] 演示租户（需要时取消注释；幂等，可重复执行）---
-- INSERT INTO tenant (code, name, status)
-- SELECT 'TD', 'TD Bank Demo', 'ACTIVE'
-- WHERE NOT EXISTS (SELECT 1 FROM tenant WHERE code = 'TD');
-- INSERT INTO tenant (code, name, status)
-- SELECT 'BMO', 'BMO Bank Demo', 'ACTIVE'
-- WHERE NOT EXISTS (SELECT 1 FROM tenant WHERE code = 'BMO');

-- --- [6] 清理测试数据（仅本地 Docker！需要时取消注释）---
-- DELETE FROM benefit;
-- DELETE FROM tenant;
