import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

mTerm       = "urxvt"

-- Focus follows mouse
mouseFocus :: Bool
mouseFocus  = True

-- window border width (pixels)
mBorderWidth   = 1 

-- mod key (mod1 = left alt, mod4 = super)
modKey       = mod1Mask

-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9] //default example
mWorkspaces     = ["1","2","3","4"]

-- window border colors 
colorUnfocused  = "#001C13"
colorFocused    = "#00FFB0"

-- Key bindings && name definitions
dMenu           = "/home/m/bui/bash/dmenucmd"
termBrs         = "urxvt -e w3m 'file:///home/m/bui/html/startpage/start.html'"
brS             = "uzbl-browser"
toDo            = "bash /home/m/bui/bash/todo"
reConf          = "xmonad --recompile 2> /home/m/.ERROR; xmonad --restart"
---
mKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $


    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_c     ), kill)
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm,               xK_n     ), refresh)
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm,               xK_comma ), sendMessage (IncMasterN 1))
    , ((modm,               xK_period), sendMessage (IncMasterN (-1)))

    -- Status bar gap from example conf
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    -- customs
    , ((modm              , xK_b     ), spawn brS           )
    , ((modm .|. shiftMask, xK_b     ), spawn termBrs       )
    , ((modm .|. shiftMask, xK_t     ), spawn toDo          )
    , ((modm,               xK_q     ), spawn reConf        )
    , ((modm,               xK_p     ), spawn dMenu         )
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]



-- Layouts
winLayout = tiled ||| Mirror tiled ||| Full
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/3
     -- window size increment (%) 
     delta   = 3/100

-- Window rules
hookManager = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    ]





main = xmonad defaults

defaults = defaultConfig {
        terminal           = mTerm,
        focusFollowsMouse  = mouseFocus,
        borderWidth        = mBorderWidth,
        modMask            = modKey,
        workspaces         = mWorkspaces,
        normalBorderColor  = colorUnfocused,
        focusedBorderColor = colorFocused,
   
        keys               = mKeys,
        layoutHook         = winLayout,
        manageHook         = hookManager
    }
