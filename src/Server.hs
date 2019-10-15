{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE RecordWildCards #-}

module Server (
  runningWebApp
) where

import Data.Proxy
import Servant.Server (serve)
import Servant ((:>), Get, JSON, Server)
import Network.Wai (Application)

import Types (Signature, signature, Env(..), environment, unMkPort)
import Network.Wai.Handler.Warp (run)
import Data.Either (Either(..))

type Api = "pricing-api" :> "health-check" :> Get '[JSON] Signature

server :: Server Api
server = pure signature

webApp :: Application
webApp = serve api server
  where api = Proxy :: Proxy Api

runningWebApp :: IO ()
runningWebApp = do
  Env{..} <- environment
  run (unMkPort port) webApp