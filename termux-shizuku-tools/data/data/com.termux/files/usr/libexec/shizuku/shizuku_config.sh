#!/data/data/com.termux/files/usr/bin/bash

source $PREFIX/libexec/shizuku/shizuku_lib.sh

SHIZUKU_CONFIG_NAME="shizuku.conf"
SHIZUKU_CONFIG_PATH="$SHIZUKU_LIB_DIR/$SHIZUKU_CONFIG_NAME"

reset_shizuku_config() {
    get_shizuku_default_config > "$SHIZUKU_CONFIG_PATH"
}

get_shizuku_default_config() {
    cat << EOF
package:moe.shizuku.privileged.api
EOF
}

get_shizuku_config() {
    if [[ ! -f "$SHIZUKU_CONFIG_PATH" ]]; then
        reset_shizuku_config
    fi
    cat "$SHIZUKU_CONFIG_PATH"
}

is_shizuku_config_key_valid() {
    local target_key="$1"
    local valid_keys=("package")

    for key in "${valid_keys[@]}"; do
        if [[ "$key" == "$target_key" ]]; then
            return 0
        fi
    done

    return 1
}

get_shizuku_config_key() {
    local target_key="$1"
    
    is_shizuku_config_key_valid "$target_key" || return 1
    
    local config_content
    config_content="$(get_shizuku_config)"
    
    printf '%s\n' "$config_content" | grep "^${target_key}:" | cut -d':' -f2-
}

get_shizuku_default_config_key() {
    local target_key="$1"
    
    is_shizuku_config_key_valid "$target_key" || return 1
    
    get_shizuku_default_config | grep "^${target_key}:" | cut -d':' -f2-
}

set_shizuku_config_key() {
    local target_key="$1"
    local new_value="$2"

    is_shizuku_config_key_valid "$target_key" || return 1

    get_shizuku_config > /dev/null

    if grep -q "^${target_key}:" "$SHIZUKU_CONFIG_PATH"; then
        sed -i "s|^${target_key}:.*|${target_key}:${new_value}|" "$SHIZUKU_CONFIG_PATH"
    else
        printf '%s:%s\n' "$target_key" "$new_value" >> "$SHIZUKU_CONFIG_PATH"
    fi
}

reset_shizuku_config_key() {
    local target_key="$1"

    is_shizuku_config_key_valid "$target_key" || return 1

    local default_val
    default_val="$(get_shizuku_default_config_key "$target_key")"
    
    if [[ -n "$default_val" ]]; then
        set_shizuku_config_key "$target_key" "$default_val"
    fi
}

shizuku_config() {
    local action="$1"
    local key="$2"
    local value="$3"

    case "$action" in
        get)
            if [[ -z "$key" ]]; then
                get_shizuku_config
                return 0
            fi
            
            is_shizuku_config_key_valid "$key" || {
                echo "Error: unknown key '$key'." >&2
                return 1
            }

            get_shizuku_config_key "$key"
            ;;

        set)
            if [[ -z "$key" || -z "$value" ]]; then
                echo "Error: key or value not specified." >&2
                echo "Usage: config set <key> <value>" >&2
                return 1
            fi

            is_shizuku_config_key_valid "$key" || {
                echo "Error: unknown key '$key'." >&2
                return 1
            }

            set_shizuku_config_key "$key" "$value"
            echo "Success: $key = $value"
            ;;

        reset)
            if [[ -n "$key" ]]; then
                is_shizuku_config_key_valid "$key" || {
                    echo "Error: unknown key '$key'." >&2
                    return 1
                }
                reset_shizuku_config_key "$key"
                echo "Key '$key' has been reset to default."
            else
                reset_shizuku_config
                echo "Configuration has been fully reset to default."
            fi
            ;;

        *)
            echo "Unknown action: '$action'" >&2
            echo "Available commands: get, set, reset" >&2
            return 1
            ;;
    esac
}