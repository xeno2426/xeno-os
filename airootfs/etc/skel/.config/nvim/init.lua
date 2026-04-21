-- ╔══════════════════════════════════════════════════════════════════╗
-- ║               Xeno OS — Neovim Configuration                    ║
-- ║  Plugin manager: lazy.nvim (auto-bootstrapped)                  ║
-- ╚══════════════════════════════════════════════════════════════════╝

-- ─── Bootstrap lazy.nvim ─────────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ─── Leader Key ──────────────────────────────────────────────────────────────
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- ─── Options ─────────────────────────────────────────────────────────────────
local opt = vim.opt
opt.number          = true
opt.relativenumber  = true
opt.signcolumn      = "yes"
opt.cursorline      = true
opt.wrap            = false
opt.linebreak       = true
opt.scrolloff       = 8
opt.sidescrolloff   = 8

-- Indentation
opt.tabstop         = 4
opt.shiftwidth      = 4
opt.softtabstop     = 4
opt.expandtab       = true
opt.smartindent     = true
opt.autoindent      = true

-- Search
opt.ignorecase      = true
opt.smartcase       = true
opt.incsearch       = true
opt.hlsearch        = false

-- Appearance
opt.termguicolors   = true
opt.laststatus      = 3   -- global statusline
opt.showmode        = false
opt.cmdheight       = 1
opt.pumheight       = 10
opt.conceallevel    = 0

-- Files
opt.encoding        = "utf-8"
opt.fileencoding    = "utf-8"
opt.undofile        = true
opt.backup          = false
opt.swapfile        = false
opt.updatetime      = 200
opt.timeoutlen      = 300

-- Clipboard
opt.clipboard       = "unnamedplus"

-- Split behaviour
opt.splitbelow      = true
opt.splitright      = true

-- ─── Keymaps ─────────────────────────────────────────────────────────────────
local map = function(mode, lhs, rhs, opts)
    opts = opts or { silent = true }
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Better escape
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- Save / Quit
map("n", "<leader>w", "<cmd>w<CR>",  { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>",  { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit all" })

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize windows
map("n", "<C-Up>",    "<cmd>resize +2<CR>")
map("n", "<C-Down>",  "<cmd>resize -2<CR>")
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Better indenting (stay in visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines up/down
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Clear search highlight
map("n", "<ESC>", "<cmd>nohlsearch<CR>")

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>",  { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",   { desc = "Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>",     { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>",   { desc = "Help" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>",    { desc = "Recent files" })

-- File explorer
map("n", "<leader>e",  "<cmd>NvimTreeToggle<CR>",        { desc = "Explorer" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>",      { desc = "Find in tree" })

-- LSP (set in on_attach)
map("n", "K",          vim.lsp.buf.hover,          { desc = "Hover docs" })
map("n", "gd",         vim.lsp.buf.definition,     { desc = "Go to definition" })
map("n", "gD",         vim.lsp.buf.declaration,    { desc = "Declaration" })
map("n", "gr",         vim.lsp.buf.references,     { desc = "References" })
map("n", "gi",         vim.lsp.buf.implementation, { desc = "Implementation" })
map("n", "<leader>rn", vim.lsp.buf.rename,         { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action,    { desc = "Code action" })
map("n", "<leader>f",  function() vim.lsp.buf.format({ async = true }) end, { desc = "Format" })
map("n", "[d",         vim.diagnostic.goto_prev,   { desc = "Prev diagnostic" })
map("n", "]d",         vim.diagnostic.goto_next,   { desc = "Next diagnostic" })
map("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics" })

-- Git
map("n", "<leader>gg", "<cmd>LazyGit<CR>",         { desc = "LazyGit" })

-- ─── Plugin Specs ────────────────────────────────────────────────────────────
require("lazy").setup({

    -- ── Colorscheme ──────────────────────────────────────────────────────────
    {
        "catppuccin/nvim",
        name     = "catppuccin",
        priority = 1000,
        opts = {
            flavour            = "mocha",
            transparent_background = false,
            show_end_of_buffer = false,
            integrations = {
                blink_cmp         = true,
                gitsigns          = true,
                nvimtree          = true,
                treesitter        = true,
                telescope         = { enabled = true },
                which_key         = true,
                indent_blankline  = { enabled = true },
                mason             = true,
                lsp_trouble       = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd("colorscheme catppuccin")
        end,
    },

    -- ── Statusline ────────────────────────────────────────────────────────────
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme            = "catppuccin",
                component_separators = { left = "", right = "" },
                section_separators  = { left = "", right = "" },
                globalstatus     = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },

    -- ── Buffer tabs ───────────────────────────────────────────────────────────
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            options = {
                diagnostics            = "nvim_lsp",
                show_buffer_close_icons = true,
                separator_style        = "slant",
                theme                  = "catppuccin",
            },
        },
    },

    -- ── File Explorer ─────────────────────────────────────────────────────────
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            sort_by = "case_sensitive",
            view    = { width = 32 },
            renderer = {
                group_empty    = true,
                highlight_git  = true,
                icons = { show = { git = true, folder = true, file = true } },
            },
            filters = { dotfiles = false },
            git     = { enable = true, ignore = false },
        },
    },

    -- ── Treesitter ────────────────────────────────────────────────────────────
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "lua", "python", "javascript", "typescript",
                "c", "cpp", "rust", "bash", "json", "yaml",
                "toml", "markdown", "html", "css", "vim",
            },
            highlight       = { enable = true },
            indent          = { enable = true },
            auto_install    = true,
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- ── Telescope ─────────────────────────────────────────────────────────────
    {
        "nvim-telescope/telescope.nvim",
        branch       = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    prompt_prefix   = "   ",
                    selection_caret = "  ",
                    path_display    = { "smart" },
                    file_ignore_patterns = { "node_modules", ".git/" },
                },
            })
            telescope.load_extension("fzf")
        end,
    },

    -- ── LSP ───────────────────────────────────────────────────────────────────
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons  = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
                },
            })
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "ts_ls", "clangd", "lua_ls" },
                automatic_installation = true,
            })

            local lspconfig    = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(_, bufnr)
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
            end

            local servers = {
                pyright   = {},
                ts_ls     = {},
                clangd    = {},
                lua_ls    = {
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace   = { checkThirdParty = false },
                            telemetry   = { enable = false },
                        },
                    },
                },
            }

            for server, config in pairs(servers) do
                config.capabilities = capabilities
                config.on_attach    = on_attach
                lspconfig[server].setup(config)
            end

            -- Diagnostic icons
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({
                virtual_text  = { prefix = "●" },
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },

    -- ── Completion ────────────────────────────────────────────────────────────
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp    = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                window = {
                    completion    = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"]    = cmp.mapping.select_prev_item(),
                    ["<C-j>"]    = cmp.mapping.select_next_item(),
                    ["<C-b>"]    = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"]    = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"]= cmp.mapping.complete(),
                    ["<C-e>"]    = cmp.mapping.abort(),
                    ["<CR>"]     = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"]    = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
                        else fallback() end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    format = function(entry, item)
                        local kind_icons = {
                            Text = "󰊄", Method = "󰆧", Function = "󰊕", Constructor = "",
                            Field = "󰇽", Variable = "󰂡", Class = "󰠱", Interface = "",
                            Module = "", Property = "󰜢", Unit = "", Value = "󰎠",
                            Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
                            File = "󰈙", Reference = "", Folder = "󰉋", EnumMember = "",
                            Constant = "󰏿", Struct = "", Event = "", Operator = "󰆕",
                            TypeParameter = "󰅲",
                        }
                        item.kind = string.format("%s %s", kind_icons[item.kind] or "", item.kind)
                        return item
                    end,
                },
            })
        end,
    },

    -- ── Git ───────────────────────────────────────────────────────────────────
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add          = { text = "▎" },
                change       = { text = "▎" },
                delete       = { text = "" },
                topdelete    = { text = "" },
                changedelete = { text = "▎" },
            },
            current_line_blame = true,
        },
    },

    -- ── Indent guides ─────────────────────────────────────────────────────────
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent   = { char = "│", highlight = "IblIndent" },
            scope    = { enabled = true, highlight = "IblScope" },
        },
    },

    -- ── Which-key ─────────────────────────────────────────────────────────────
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts  = {
            window = { border = "rounded" },
            layout = { align = "center" },
        },
    },

    -- ── Autopairs ─────────────────────────────────────────────────────────────
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = { check_ts = true } },

    -- ── Comments ──────────────────────────────────────────────────────────────
    { "numToStr/Comment.nvim", opts = {} },

    -- ── LazyGit ───────────────────────────────────────────────────────────────
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- ── Dashboard ─────────────────────────────────────────────────────────────
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local alpha   = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.header.val = {
                "  ██╗  ██╗███████╗███╗   ██╗ ██████╗      ██████╗ ███████╗",
                "  ╚██╗██╔╝██╔════╝████╗  ██║██╔═══██╗    ██╔═══██╗██╔════╝",
                "   ╚███╔╝ █████╗  ██╔██╗ ██║██║   ██║    ██║   ██║███████╗",
                "   ██╔██╗ ██╔══╝  ██║╚██╗██║██║   ██║    ██║   ██║╚════██║",
                "  ██╔╝ ██╗███████╗██║ ╚████║╚██████╔╝    ╚██████╔╝███████║",
                "  ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝      ╚═════╝ ╚══════╝",
            }
            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find file",    "<cmd>Telescope find_files<CR>"),
                dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
                dashboard.button("g", "  Grep",         "<cmd>Telescope live_grep<CR>"),
                dashboard.button("e", "  Explorer",     "<cmd>NvimTreeToggle<CR>"),
                dashboard.button("s", "  Settings",     "<cmd>e $MYVIMRC<CR>"),
                dashboard.button("q", "  Quit",         "<cmd>qa<CR>"),
            }
            alpha.setup(dashboard.opts)
        end,
    },

}, {
    -- lazy.nvim UI settings
    ui = {
        border  = "rounded",
        icons   = { cmd = "", config = "", event = "", ft = "", init = "", keys = "", plugin = "", runtime = "", source = "", start = "", task = "", lazy = "󰒲 " },
    },
    checker = { enabled = true, notify = false },
    change_detection = { notify = false },
})
