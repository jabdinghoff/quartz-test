import { loadQuartzConfig, loadQuartzLayout } from "./quartz/plugins/loader/config-loader"
import { componentRegistry } from "./quartz/components/registry"

// Sort folders and notes together by name (numbers compared numerically), so "01 …" prefixes
// order the explorer the same way as Obsidian's file list. Must be self-contained: the explorer
// serialises it and rebuilds it in the browser.
const explorerOverrides = {
  sortFn: (a: { displayName: string }, b: { displayName: string }) =>
    a.displayName.localeCompare(b.displayName, undefined, { numeric: true, sensitivity: "base" }),
}
// Overrides are keyed by the plugin's source name from quartz.config.yaml.
componentRegistry.setOptionOverrides("@quartz-community/explorer", explorerOverrides)

const config = await loadQuartzConfig()
export default config
export const layout = await loadQuartzLayout()
