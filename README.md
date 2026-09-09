# 网文写作 Skill

一个面向中文网络文学创作的、可持续迭代的提示词 Skill。它不替作者决定题材、情节或文风，而是把创作流程拆成可复用的协议：**讨论 → 评审 → 章纲 → 正文 → 修订**。

## 项目署名

- 作者：**llsysklt**
- Skill 训练者：**guyao146**

## 核心原则

- 写作阶段只读取 `prompts/writing.md`；修订阶段才读取 `prompts/revision.md` 与 `prompts/anti-overfitting.md`。
- 内部推演（锁定、状态、节拍）不输出。
- 规则是过滤器，不是声音来源；事件先于句式，人物先于漂亮话。
- 用户明确要求与硬规则冲突时，以用户要求为先，并在执行前简短标记被覆盖的规则编号。

## 使用

将 `SKILL.md` 作为 Skill 入口提供给支持 Markdown 指令的 Agent。开始项目时复制：

```text
templates/project-bible.md  → 你的项目/项目设定.md
templates/character-card.md  → 你的项目/角色卡/角色名.md
templates/chapter-state.md   → 你的项目/状态/第001章.md
```

一次请求建议说明：模式、章节号、视角、已知剧情、目标效果、篇幅和不可改变的事实。正文模式的最终输出必须是纯文本正文，不得输出分析、规则或 Markdown。

## 目录

| 路径 | 用途 |
| --- | --- |
| `SKILL.md` | Agent 入口与路由协议 |
| `prompts/` | 分阶段规则；刻意隔离写作与修订 |
| `templates/` | 可持久化的项目资料模板 |
| `schemas/` | 请求与状态的数据契约 |
| `docs/` | 使用、设计与迭代说明 |
| `scripts/validate.ps1` | 无第三方依赖的结构校验 |

## 开发与迭代

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate.ps1
```

新增规则时先判断它属于“声音来源”“写作约束”还是“修订病征”。不要把修订红名单放进写作提示词。详见 [`docs/CONTRIBUTING.md`](docs/CONTRIBUTING.md)。

## 许可

本项目沿用仓库中的 `LICENSE`。提交第三方样本、人物原型或测试文本前，请确认拥有相应授权。