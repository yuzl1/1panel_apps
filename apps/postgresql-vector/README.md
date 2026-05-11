## 产品介绍

**PostgreSQL-Vector** 是一个基于 PostgreSQL 18 开发版构建的强大关系型数据库管理系统（RDBMS），并预装了 **pgvector** 扩展。它结合了传统数据库的可靠性与现代 AI 应用所需的向量检索能力，是构建大模型应用（如 Dify）和复杂业务系统（如“优课乐陵”交易系统）的理想选择。



## 核心增强：向量检索 (pgvector)
- **AI 赋能**：原生支持向量数据类型，可存储和检索 Embedding，不再报错 `extension "vector" is not available`。
- **环境优化**：基于 Debian Bookworm 构建，比 Alpine 版本更稳定，且由于是预装版，无需手动通过 `apk` 或 `apt` 安装。
- **与官方共存**：默认使用 5433 端口，容器名独立，可与官方 PostgreSQL 同时运行而互不干扰。

## 主要功能

- **向量与关系型数据集成**：允许在同一个数据库中处理业务逻辑与语义搜索，通过 SQL 即可完成相似度计算。
- **ACID 遵从与可靠性**：遵循 ACID 属性，确保在系统故障的情况下也能保持同城交易数据的完整性。
- **多版本并发控制 (MVCC)**：允许多个用户同时访问预约系统和交易平台，而不会导致数据冲突。
- **高级查询优化**：提供强大的查询优化器，即便在包含数千张表的复杂 Schema（如 PostgreSQL 大表内省）中也能保持高性能。
- **JSONB 原生支持**：完美处理半结构化数据，非常适合存储课程详情、商家配置等灵活信息。
- **备份与恢复**：支持在线备份操作，确保您的业务数据和 AI 知识库具备极高的安全性。

## 安装后第一步

安装完成后，请使用 pgAdmin 4、DataGrip 或其他客户端连接数据库，并在目标数据库下运行以下 SQL 语句激活向量功能：

```sql
-- 激活向量扩展
CREATE EXTENSION IF NOT EXISTS vector;

-- 验证是否安装成功
SELECT extname, extversion FROM pg_extension WHERE extname = 'vector';