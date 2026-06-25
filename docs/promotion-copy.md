# Promotion Copy

## 50-character version

AI Coding Collaboration: a Codex skill for task grading, minimal-diff implementation, validation discipline, and concise handoff summaries.

## 200-character version

I packaged my AI coding collaboration workflow into a Codex skill. It helps classify tasks into L0/L1/L2/L3, avoid oversized diffs, check missing impacts, validate P0 paths, and end with an evidence-based executive summary.

Repository: https://github.com/yeqiana/ai-coding-collaboration

## Chinese short post

我把平时约束 AI 写代码的流程沉淀成了一个 Codex skill：AI Coding Collaboration。

它主要解决几个问题：

- 小任务被 AI 做成大重构
- 改动范围失控
- 接口 / DTO / 数据库 / 测试影响漏掉
- 最后只说“完成了”，但没有验证证据

这个 skill 会让 AI 先判断任务属于 L0/L1/L2/L3，再选择对应流程，按最小 Diff 实施，并用 P0/P1/P2 做验证分级。

仓库： https://github.com/yeqiana/ai-coding-collaboration

## Long-form outline

Title:

```text
我把 AI 编程协作规范做成了一个 Codex Skill
```

Structure:

```text
1. 为什么需要这个 skill
   - AI 容易过度设计
   - 小任务输出大方案
   - 改代码但不验证
   - 总结缺少证据链

2. 它怎么工作
   - L0/L1/L2/L3 任务分级
   - 最小 Diff 原则
   - 影响分析
   - P0/P1/P2 测试分级
   - Executive Summary

3. 适合什么场景
   - Bug fix
   - 小功能
   - 模块级改造
   - Code review

4. 不适合什么场景
   - 不替代领域知识
   - 不保证自动写出正确代码
   - 不解决所有项目管理问题

5. 如何安装和使用
   - git clone 到 ~/.codex/skills
   - Use $ai-coding-collaboration ...

6. 后续计划
   - 更多示例
   - GitHub Actions 校验
   - 中英文 README
```

Repository:

```text
https://github.com/yeqiana/ai-coding-collaboration
```
