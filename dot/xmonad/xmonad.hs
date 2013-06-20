import System.Posix.Env (getEnv)
import Data.Map as M  (fromList,union, Map())

import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig


myKeys conf@(XConfig {XMonad.modMask = modm}) =
    [
     ((0, xK_Print), spawn "scrot -e 'mv $f ~/media/ss'")
    -- the sleep needs to be there so scrot doesn't process the key_up from us calling it
    , ((modm, xK_Print), spawn "sleep .2;scrot -s -e 'mv $f ~/media/ss'")
    ]
newKeys x = M.union (keys defaultConfig x) (M.fromList (myKeys x))

mylayoutHook = smartBorders $ layoutHook defaultConfig

main = do
     spawn "/usr/libexec/polkit-gnome-authentication-agent-1"
     xmonad  gnomeConfig
            { layoutHook         = mylayoutHook
            , keys = newKeys
            }
