# Sidekiq::Retries

This subclasses the stock Sidekiq retries middleware to give you some additional options to conditionally retry jobs
irrespective of whether retries are enabled for the job.

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq-retries'

## Usage

    class NoRetryJob
      include Sidekiq::Worker
      sidekiq_options retry: false

      def perform
        # force a retry
        raise Sidekiq::Retries::Retry.new(RuntimeError.new('whatever happened'))        
      end
    end
    
    class RetryJob
      include Sidekiq::Worker
      sidekiq_options retry: 25
    
      def perform                        
        # fail the job, don't retry it 
        raise Sidekiq::Retries::Fail.new(RuntimeError.new('whatever happened'))
      end
    end
    
## Caveats

* Jobs with retry: 0 don't ever appear to show up in the Sidekiq 3 Dead queue

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
