NativeDbTypesOverride.configure({
  postgres: {
    datetime: { name: "timestamptz" },
    timestamp: { name: "timestamptz" }
  }
})
