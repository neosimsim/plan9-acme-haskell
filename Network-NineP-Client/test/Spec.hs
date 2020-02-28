module Main
  ( main
  ) where

import           Network.NineP.Client (getNamespace)
import           System.Environment   (setEnv, unsetEnv)
import           Test.Hspec           (before_, describe, hspec, it,
                                       shouldReturn)

main :: IO ()
main =
  hspec $
  describe "Network.NineP.Client.getNamespace" $
  before_ (unsetEnv "NAMESPACE") $ -- make sure the default namespace is used
   do
    it "defaults to /tmp/ns.USER.:0" $ do
      unsetEnv "DISPLAY"
      setEnv "USER" "whoami"
      getNamespace `shouldReturn` "/tmp/ns.whoami.:0"
    it "recognizes $DISPLAY" $ do
      setEnv "DISPLAY" ":0"
      setEnv "USER" "whoami"
      getNamespace `shouldReturn` "/tmp/ns.whoami.:0"
    it "recognizes $NAMESPACE" $ do
      setEnv "NAMESPACE" "/path/to/namespace"
      getNamespace `shouldReturn` "/path/to/namespace"
    it "canonicalizes the display" $ do
      setEnv "DISPLAY" "xxx:0.0"
      setEnv "USER" "whoami"
      getNamespace `shouldReturn` "/tmp/ns.whoami.xxx:0"
    it "turns /tmp/launch/:0 into _tmp_launch_:0 (OS X 10.5)" $ do
      setEnv "DISPLAY" "/tmp/launch/:0"
      setEnv "USER" "whoami"
      getNamespace `shouldReturn` "/tmp/ns.whoami._tmp_launch_:0"
