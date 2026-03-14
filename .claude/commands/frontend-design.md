---
name: frontend-design
description: "Use when the user writes 'frontend-design' - activates UI/UX-focused development mode. Expert in React components, Tailwind CSS v4, Radix UI, shadcn/ui, responsive design, accessibility, and modern frontend patterns."
---

# Frontend Design Mode

## Overview

Specialized mode for frontend development focusing on UI/UX quality, component design, accessibility, and visual polish. Every component should be production-ready with proper styling, interactions, and responsive behavior.

## When to Use

**TRIGGER:** User explicitly writes "frontend-design" in their request.

## Tech Stack (Terragon)

| Technology          | Usage                                  |
| ------------------- | -------------------------------------- |
| **React 19**        | UI framework with Server Components    |
| **Next.js 15**      | App Router, Server Actions, middleware |
| **Tailwind CSS v4** | Utility-first styling                  |
| **Radix UI**        | Accessible primitives                  |
| **shadcn/ui**       | Pre-built component library            |
| **Jotai**           | Client-side state management           |
| **React Query**     | Server state and caching               |
| **Framer Motion**   | Animations and transitions             |
| **Lucide React**    | Icon library                           |

## Design Principles

### 1. Component Architecture

- **Composition over inheritance**: Build complex UIs from simple, composable pieces
- **Controlled vs Uncontrolled**: Default to controlled components with clear prop APIs
- **Render props / Children patterns**: Use for flexible component composition
- **Forward refs**: Always forward refs on wrapper components

### 2. Styling Guidelines

- Use Tailwind CSS utility classes as primary styling method
- Follow the existing design tokens and color scheme
- Use CSS variables for theming (`var(--color-*)`)
- Avoid inline styles except for dynamic values
- Use `cn()` utility for conditional class merging

### 3. Responsive Design

- Mobile-first approach with Tailwind breakpoints
- Test layouts at: `sm` (640px), `md` (768px), `lg` (1024px), `xl` (1280px)
- Use CSS Grid and Flexbox for layouts
- Ensure touch targets are at least 44x44px on mobile

### 4. Accessibility (a11y)

- Use semantic HTML elements (`button`, `nav`, `main`, `article`, etc.)
- Include proper ARIA attributes when semantic HTML isn't sufficient
- Ensure keyboard navigation works (Tab, Enter, Escape, Arrow keys)
- Maintain sufficient color contrast (WCAG AA minimum)
- Add `sr-only` text for icon-only buttons
- Test with screen reader patterns in mind

### 5. Interactions & Animations

- Use `transition-*` for simple hover/focus states
- Use Framer Motion for complex animations
- Respect `prefers-reduced-motion`
- Keep animations under 300ms for UI feedback
- Add loading states for async operations

### 6. Performance

- Lazy load heavy components with `React.lazy()` and `Suspense`
- Use `useMemo` and `useCallback` only when measurably needed
- Optimize images with Next.js `Image` component
- Avoid layout shifts (reserve space for dynamic content)

## Component Template

When creating new components, follow this structure:

```tsx
"use client"; // Only if client interactivity is needed

import { type ComponentProps } from "react";
import { cn } from "@/lib/utils";

interface MyComponentProps extends ComponentProps<"div"> {
  // Component-specific props
  variant?: "default" | "outline";
}

export function MyComponent({
  variant = "default",
  className,
  children,
  ...props
}: MyComponentProps) {
  return (
    <div
      className={cn(
        "base-styles-here",
        variant === "outline" && "outline-variant-styles",
        className,
      )}
      {...props}
    >
      {children}
    </div>
  );
}
```

## shadcn/ui Usage

- Check existing components in `apps/www/src/components/ui/` before creating new ones
- Use `npx shadcn@latest add <component>` to add new shadcn components
- Customize via the component file, not by wrapping
- Follow the established variants pattern

## Form Patterns

- Use React Hook Form for complex forms
- Use Zod for schema validation
- Show inline validation errors below fields
- Disable submit button during submission
- Show loading spinners for async operations
- Handle server-side validation errors

## Context Compaction

When summarizing context, ALWAYS include:

```
TRYB PRACY: frontend-design - kontynuuj pracę w trybie projektowania frontendu
```
