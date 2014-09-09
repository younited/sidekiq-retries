# Sidekiq::Retries

[![Build Status](https://travis-ci.org/govdelivery/sidekiq-retries.svg?branch=master)](https://travis-ci.org/govdelivery/sidekiq-retries)

This subclasses the stock Sidekiq retries middleware so that you can

* retry a job that has retries disabled (retry: 0 or retry: false)
* abort (don't retry) a job that will otherwise retry by default

but still have the job raise an exception so that you can observe that the job failed (by checking the logs,
using sidekiq-failures, etc.).

Don't use this as a replacement for making your jobs idempotent!


## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq-retries'



## Usage

    class NoRetryJob
      include Sidekiq::Worker
      sidekiq_options retry: false  # or retry: 0

      def perform
        # retry this job when it otherwise would not
        raise Sidekiq::Retries::Retry.new(RuntimeError.new('whatever happened'))        
      end
    end
    
    class RetryJob
      include Sidekiq::Worker
      sidekiq_options retry: 25
    
      def perform                        
        # don't retry this particular job
        raise Sidekiq::Retries::Fail.new(RuntimeError.new('whatever happened'))
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
