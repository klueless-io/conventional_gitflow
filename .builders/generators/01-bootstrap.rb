KManager.action :bootstrap do
  def on_action
    application_name = :conventional_gitflow
    director = Dsl::RubyGemDsl
      .init(k_builder,
        template_base_folder: 'ruby/gem',
        on_exist:             :compare,     # %i[skip write compare]
        on_action:            :queue,      # %i[queue execute]
        repo_name:            application_name,
        application:          application_name
      )
      .github do
        parent.options.repo_info = repo_info
        # delete_repository # (name: :xmen, organization: 'klueless-webpack5-samples')
        # sleep 2; open_repository # (name: :xmen, organization: 'klueless-webpack5-samples')
        create_repository # (name: :xmen, organization: 'klueless-webpack5-samples')
        # sleep 2; open_repository # (name: :xmen, organization: 'klueless-webpack5-samples')
        # list_repositories
      end
      .blueprint(
        name: :bin_hook,
        description: 'BIN/Hook structures',
        on_exist: :write) do

        cd(:app)
        debug

        dom = parent.options.to_h
          .merge(options.to_h)
          .merge(
            common_sh: template_content('bin/runonce/common.sh')
          )

          log.line
          log.structure(dom)

        # tadd('.gitignore')

        # add('hooks/pre-commit')
        # add('hooks/update-version')
    
        # add('bin/setup', dom: dom)
        # add('bin/console', dom: dom)
    
        run_command('git init')
        run_template_script('bin/runonce/git-setup.sh', dom: dom)
      end

    # director.k_builder.debug
    director.play_actions
    # director.builder.logit
  end
end
