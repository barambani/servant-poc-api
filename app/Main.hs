module Main where

import Network.Wai.Handler.Warp (run)
import Server (webApp)

main :: IO ()
main = run 808 webApp
