KManager.action :bootstrap do
  def on_action
    application_name = :conventional_gitflow
    director = Dsl::RubyGemDsl
      .init(k_builder,
        template_base_folder:       'ruby/gem',
        on_exist:                   :compare,                   # %i[skip write compare]
        on_action:                  :queue,                     # %i[queue execute]
        repo_name:                  application_name,
        application:                application_name,
        description:                'Conventional Gitflow provides tools for conventional git workflows including changelogs and SemVer',
        application_lib_path:       'conventional_gitflow',
        application_lib_namespace:  'ConventionalGitflow',
        namespaces:                 ['ConventionalGitflow'],
        author:                     'David Cruwys',
        author_email:               'david@ideasmen.com.au',
        avatar:                     'Developer',
        main_story:                 'As a Developer, I want to use conventional commits, so that I can build conventional git based workflows such as SemVer and ChangeLogs',
        copyright_date:             '2022',
        website:                    'http://appydave.com/gems/conventional-gitflow'
      )
      .github do
        parent.options.repo_info = repo_info
        # delete_repository # (name: :xmen, organization: 'klueless-webpack5-samples')
        # sleep 2; open_repository # (name: :xmen, organization: 'klueless-webpack5-samples')
        # create_repository # (name: :xmen, organization: 'klueless-webpack5-samples')
        # sleep 2; open_repository # (name: :xmen, organization: 'klueless-webpack5-samples')
        # list_repositories
      end
      .blueprint(name: :bin_hook) do

        cd(:app)

        self.dom = parent.options.to_h
          .merge(options.to_h)
          .merge(
            common_sh: template_content('bin/runonce/common.sh')
          )

        # debug
        # log.line
        # log.structure(dom)

        # add('.gitignore')

        # add('hooks/pre-commit')         # NOT IMPLEMENTED
        # add('hooks/update-version')     # NOT IMPLEMENTED
    
        # add('bin/setup', dom: dom)
        # add('bin/console', dom: dom)
    
        # run_command('git init')
        # run_template_script('bin/runonce/git-setup.sh', dom: dom)
      end
      .blueprint(name: :gem_boilerplate, on_exist: :write) do

        self.dom = parent.options.to_h
          .merge(options.to_h)
          .merge(repo_info: parent.options[:repo_info])

        # add('lib/conventional_gitflow.rb'         , template_file: 'lib/applet_name.rb'       , cop: true)
        # add('lib/conventional_gitflow/version.rb' , template_file: 'lib/applet_name/version.rb')
        # add('spec/conventional_gitflow_spec.rb'   , template_file: 'spec/applet_name_spec.rb' , cop: true)
    
        # add('spec/spec_helper.rb')

        # add('.rspec')
        # add('.rubocop.yml')
        # add('conventional_gitflow.gemspec'         , template_file: 'applet_name.gemspec')
        # add('CODE_OF_CONDUCT.md')
        # add('Gemfile')
        # add('Guardfile')
        # add('LICENSE.txt')
        # add('Rakefile')
        # oadd('README.md')
        # run_command('rubocop -A')
      end
      .blueprint do
        self.dom = parent.options.to_h
          .merge(options.to_h)
          .merge(repo_info: parent.options[:repo_info])

        oadd('.github/workflows/main.yml')
      end

    # director.k_builder.debug
    director.play_actions
    director.builder.logit
  end
end
