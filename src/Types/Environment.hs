{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Types.Environment (
  Env (..),
  environment,
  unMkPort
) where

import System.Envy
import GHC.Generics (Generic)
import Control.Monad.Except
import Control.Monad.IO.Class (liftIO, MonadIO)
import Control.Exception.Base (IOException)

newtype Port = Port { unMkPort :: Int } deriving (Eq, Show, Generic, Var)

data Env = Env {
  port :: Port
} deriving (Eq, Show, Generic)
instance FromEnv Env

environment :: (MonadIO m, MonadError IOException m) => m Env
environment = liftIO decodeEnv >>=
  \case
    Left er -> throwError $ userError ("Env Variables Error: " <> er)
    Right env -> pure env
