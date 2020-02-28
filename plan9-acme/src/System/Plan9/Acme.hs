module System.Plan9.Acme
  ( new
  ) where

type Win = Integer

new :: IO Win
new = return 0
