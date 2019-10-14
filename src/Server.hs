{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Server (
  webApp
) where

import Data.Proxy
import Servant.Server (serve)
import Servant ((:>), Get, JSON, Server)
import Network.Wai (Application)

import Types (Signature, signature)

type Api =
  "pricing-api" :> "health-check" :> Get '[JSON] Signature

server :: Server Api
server = pure signature

webApp :: Application
webApp = serve api server
  where api = Proxy :: Proxy Api
