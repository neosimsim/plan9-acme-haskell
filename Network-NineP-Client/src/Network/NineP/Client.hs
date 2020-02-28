module Network.NineP.Client
  ( mountService
  , mount
  , dialService
  , dial
  , getNamespace
  ) where

import           Data.Maybe         (fromMaybe)
import           System.Environment (getEnv, lookupEnv)
import           Text.Regex.TDFA    ((=~))

-- dial
data Conn

data Fid

type Fsys = Fid

dialService :: String -> Conn
dialService = undefined

dial :: String -> String -> Conn
dial = undefined

mountService :: String -> Fsys
mountService = undefined

mount :: String -> String -> Fsys
mount = undefined

getNamespace :: IO String
getNamespace = do
  namespaceEnv <- lookupEnv "NAMESPACE"
  case namespaceEnv of
    Just namespace -> return namespace
    Nothing
      -- No $DISPLAY? Use :0.0 for non-X11 GUI (OS X).
     -> do
      displayEnv <- fromMaybe ":0.0" <$> lookupEnv "DISPLAY"
      let foo = canonicalize displayEnv
      let display = replace <$> foo
      username <- getEnv "USER"
      return $ "/tmp/ns." ++ username ++ "." ++ display
  where
    replace :: Char -> Char
    replace '/' = '_'
    replace c   = c
    -- Canonicalize: xxx:0.0 => xxx:0.
    canonicalize display =
      case canonicalMatch display of
        (_, _, _, [canonicalDisplay]) -> canonicalDisplay
        _                             -> display
    canonicalMatch :: String -> (String, String, String, [String])
    canonicalMatch = (=~ "^(.*:[0-9]+)\\.0$")
