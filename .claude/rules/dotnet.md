---
paths:
  - "**/*.cs"
  - "**/*.csproj"
  - "**/*.sln"
  - "**/*.slnx"
---

# .NET conventions

## C#

- **One type per file**: each class, interface, enum, and record gets its own file, named after the type.
- **Namespaces match folder structure**: the namespace must reflect the full folder path relative to the project root.
- **Extension members**: use the C# 14 `extension(Type receiver) { }` block syntax instead of the old `static class` with `this` parameters.
- **Consolidate extensions logically**: put all extension blocks for a layer in one file per namespace (for example `DomainExtensions.cs`, `ContractExtensions.cs`). Do not create one file per extended type.
- **Always use curly braces for `if` and `else` statements**: even single-line bodies must use `{ }`.
- **Always add a blank line after the closing `}` of a block statement** (`if`, `else`, `for`, `foreach`, `while`, `using`). Skip the blank line when the block is the last statement in its container.
- **Prefer modern C# language features**: use the latest constructs over older equivalents. When multiple approaches exist, choose the most expressive one the language version supports. Examples:
  - pattern matching instead of null checks and type tests
  - switch expressions instead of switch statements
  - target-typed `new`, null-coalescing operators, and range and index operators

## Testing

- Use **xUnit**, **AwesomeAssertions**, and **NSubstitute**.
- Prefer mocks over fakes.

## Documentation

- When you mention .NET in text, do not use a version number. The version changes often, so the text goes stale.
