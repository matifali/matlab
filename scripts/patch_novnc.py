#!/usr/bin/env python3
"""
Patch noVNC to use relative WebSocket URLs for Coder subpath proxy support.
This patch allows noVNC to work with both subdomain and path-based proxies.
"""

import sys

NOVNC_UI_JS = '/opt/noVNC/app/ui.js'

old_code = """        let url;

        url = UI.getSetting('encrypt') ? 'wss' : 'ws';

        url += '://' + host;
        if (port) {
            url += ':' + port;
        }
        url += '/' + path;"""

new_code = """        let url;
        // Use relative WebSocket URL for Coder proxy support (works with both subdomain and path-based)
        const wsProtocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
        const pathname = window.location.pathname;
        const basePath = pathname.substring(0, pathname.lastIndexOf('/') + 1);
        url = wsProtocol + '//' + window.location.host + basePath + path;"""

def main():
    try:
        with open(NOVNC_UI_JS, 'r') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: {NOVNC_UI_JS} not found")
        sys.exit(1)

    if old_code in content:
        content = content.replace(old_code, new_code)
        with open(NOVNC_UI_JS, 'w') as f:
            f.write(content)
        print("noVNC patched successfully for relative WebSocket URLs")
    elif "basePath = window.location.pathname" in content:
        print("noVNC already patched")
    else:
        print("Warning: Expected pattern not found in ui.js - noVNC version may be incompatible")
        sys.exit(1)

if __name__ == '__main__':
    main()
