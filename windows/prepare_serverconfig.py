"""
Creates a serverconfig.lua using a template file and a JSON parameter file. 
Outputs serverconfig.lua in current dir.
Template lua should be a valid serverconfig.lua with the following templates:

params JSON is:
{
    "template": "NameOfServerconfigTemplate",
    "tribesServerName": "Some Server",
    "tribesServerAdminPassword": "<admin_password>",
    "tribesServerPassword": "<password>"
}

Usage prepare_serverconfig.py <params.json>
"""
import os
import sys
import json

TEMPLATE_DIR = "serverconfig_templates"
SERVER_PASSWORD = "ServerSettings.Password = \"%s\""
SERVER_ADMIN_PASSWORD = "Admin.Roles.add(\"admin\", \"%s\", true)"

# validation
TEMPLATE_REQUIRED_PARAMS = [
    "tribesServerName",
    "tribesServerPassword",
    "tribesServerAdminPassword"
]

# validation
TEMPLATE_FORBIDDEN_STRINGS = [
    # template configs should not have hardcoded passwords
    "ServerSettings.Password",
    "Admin.roles.add"
]

def replace(param_name, config, params, template=None):
    param_pattern = "{{%s}}" % param_name
    if template:
        if params.get(param_name) and len(params[param_name]):
            param_value = template % params[param_name]
        else:
            param_value = ""
    else:
        param_value = params[param_name]
    
    return config.replace(param_pattern, param_value)

def generate(args):
    # TODO: validate args/input
    params_file = args[0]
    
    with open(params_file) as f:
        params = json.load(f)

    template_file = os.path.join(TEMPLATE_DIR, "%s.lua" % params["tribesServerTemplate"])
    
    with open(template_file) as f:
        template = f.read()

    # replace params
    config = template
    config = replace("tribesServerName", config, params)
    config = replace("tribesServerPassword", config, params, template=SERVER_PASSWORD)
    config = replace("tribesServerAdminPassword", config, params, template=SERVER_ADMIN_PASSWORD)
    
    # output serverconfig.lua
    with open("serverconfig.lua", 'w') as f:
        f.write(config)

def validate(args):
    """validate all templates in TEMPLATE_DIR"""
    for child in os.listdir(TEMPLATE_DIR):
        if child.endswith('.lua'):
            with open(os.path.join(TEMPLATE_DIR, child)) as f:
                config = f.read()
            
            for p in TEMPLATE_REQUIRED_PARAMS:
                if p not in config:
                    print(f"{child} is missing required param {p}")

            for s in TEMPLATE_FORBIDDEN_STRINGS:
                if s in config:
                    print(f"{child} contains forbidden substring '{s}'")

def main():
    mode = sys.argv[1]
    args = sys.argv[2:]

    if mode == 'validate':
        validate(args)
    elif mode == 'generate':
        generate(args)
    else:
        print(f"command {mode} not valid")

if __name__ == '__main__':
    main()
