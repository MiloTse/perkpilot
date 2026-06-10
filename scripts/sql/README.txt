开发手测：只维护 scripts/sql/local-dev.sql（用注释区分各段 SQL，选中后 Ctrl+Enter 执行）。
IDEA 数据源：perkpilot@localhost:5433

正式迁表（应用启动自动执行）：
  backend/perkpilot-api-app/src/main/resources/db/migration/V*.sql
