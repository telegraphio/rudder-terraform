# Rudderstack in the Telegeraph AWS Env.

## Deploy

1. Clone https://github.com/telegraphio/rudder-terraform and cd to rudder-terraform/
2. Get the Rudderstack SSH keypair from Lastpass and install locally in yoour ~/.ssh directory
3. Login into Rudderstack using the creds from LastPass and click Connections. Grab the Token and use it to update the `CONFIG_BACKEND_TOKEN` in [dataplane.env](./dataplane.env)
4. Run the following commands:
    
    ```
    terraform init
    terraform validate
    terraform apply
    ```

You should now be able to test the setup using curl - follow these [instructions](https://github.com/telegraphio/rudder-terraform#test-your-setup). For the source key, use the write key from the Rudderstack [JS source](https://app.rudderstack.com/sources/1zYTCGKV2PI5OfyurY4AvRfLJYs).