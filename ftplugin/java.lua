local project_home = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:n:t')

local home = os.getenv('HOME')

local workspace_dir = home .. '/.local/share/jdtls/workspace/' .. project_home

local jdtls_home = home .. '/.local/jdtls/'

local jdtls_version = '1.6.400.v20210924-0641'

local lombok_jar = home .. '/.local/jars/lombok.jar'

local config = {
    cmd = {
        'java',
        '-javaagent:' .. lombok_jar,
        --'-Xbootclasspath/a:' .. lombok_jar,
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-noverify',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', jdtls_home .. 'plugins/org.eclipse.equinox.launcher_' .. jdtls_version .. '.jar',
        '-configuration', jdtls_home .. 'config_linux',
        '-data', workspace_dir
    },

    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

    settings = {
        java = {
        }
    },

    init_options = {
        bundles = {}
    },
}

--require('jdtls').start_or_attach(config)
