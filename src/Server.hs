{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Server (
  runningWebApp
) where

import Data.Proxy
import Servant.Server (serve)
import Servant ((:>), Get, JSON, Server, (:<|>)(..), Post, ReqBody, Handler)
import Network.Wai (Application)

import Types.Environment (Env(..), environment, unMkPort)
import Types.HealthCheck (Signature)
import Types.Prices (PricesRequestPayload, Price)
import Network.Wai.Handler.Warp (run)
import Data.Either (Either (..))
import Api (prices, signature)

type Endpoints =
  "pricing-api" :> "prices" :> ReqBody '[JSON] PricesRequestPayload :> Post '[JSON] [Price]
  :<|> "pricing-api" :> "health-check" :> Get '[JSON] Signature

server :: Server Endpoints
server =
  prices
  :<|> pure signature

webApp :: Application
webApp = serve endpoints server
  where endpoints = Proxy :: Proxy Endpoints

runningWebApp :: IO ()
runningWebApp = do
  environment <- environment
  run ((unMkPort . port) environment) webApp