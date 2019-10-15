{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Types (
  Env (..),
  environment,
  unMkPort,
  Signature,
  signature
) where

import Data.Text
import GHC.Generics
import Data.Aeson.Types (ToJSON)
import System.Envy
import Control.Monad.IO.Class (liftIO, MonadIO)
import Control.Monad.Except
import Control.Exception.Base (IOException)

newtype Port = Port { unMkPort :: Int } deriving (Eq, Show, Generic, ToJSON, Var)

data Env = Env {
  port :: Port
} deriving (Eq, Show, Generic)
instance ToJSON Env
instance FromEnv Env

environment :: (MonadIO m, MonadError IOException m) => m Env
environment = liftIO decodeEnv >>=
  \case
    Left er -> throwError $ userError ("Env Variables Error: " <> er)
    Right env -> pure env

data Signature = Signature {
  name           :: Text,
  version        :: Text,
  haskellVersion :: Text,
  buildTime      :: Text
} deriving (Eq, Show, Generic)
instance ToJSON Signature

signature :: Signature
signature = Signature
  "servant-poc-api"
  "0.0.1.0"
  "lts-14.6 (ghc-8.6.5)"
  "now"