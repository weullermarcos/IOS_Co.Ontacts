//
//  Contato+CoreDataProperties.h
//  CoOntacts
//
//  Created by Weuller Marcos on 23/12/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "Contato+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contato (CoreDataProperties)

+ (NSFetchRequest<Contato *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *descricao;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, retain) NSData *imagem;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, copy) NSString *nome;
@property (nullable, nonatomic, copy) NSString *telefone;

@end

NS_ASSUME_NONNULL_END
